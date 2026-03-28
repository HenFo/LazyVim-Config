return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      local launch_cwd = vim.fs.normalize(vim.uv.cwd())
      local function clamp_to_launch_cwd(path)
        path = path and vim.fs.normalize(path) or nil
        if path and (path == launch_cwd or vim.startswith(path, launch_cwd .. "/")) then
          return path
        end
        return launch_cwd
      end

      local existing_root_dir = opts.root_dir
      opts.root_dir = function(path)
        local detected = existing_root_dir and existing_root_dir(path)
          or vim.fs.root(path, vim.lsp.config.jdtls.root_markers)
        return clamp_to_launch_cwd(detected)
      end

      local jdtls_java_path = vim.env.JDTLS_JAVA_PATH
      if jdtls_java_path and jdtls_java_path ~= "" then
        local base_cmd = opts.cmd or { vim.fn.exepath("jdtls") }
        if base_cmd[1] == "" then
          base_cmd[1] = "jdtls"
        end

        local cmd = { base_cmd[1], "--java-executable=" .. jdtls_java_path }
        for i, arg in ipairs(base_cmd) do
          if i > 1 and type(arg) == "string" and not vim.startswith(arg, "--java-executable=") then
            table.insert(cmd, arg)
          end
        end
        opts.cmd = cmd
      end

      local project_java_home = vim.env.JAVA_HOME
      if project_java_home and project_java_home ~= "" then
        local project_java_exec = vim.fs.joinpath(project_java_home, "bin", "java")
        opts.dap = opts.dap or {}
        opts.dap.config_overrides = vim.tbl_deep_extend("force", opts.dap.config_overrides or {}, {
          javaExec = project_java_exec,
        })
      end

      return opts
    end,
  },
}
