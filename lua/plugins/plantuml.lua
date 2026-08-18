return {
  "charlesnicholson/plantuml.nvim",
  opts = {
    use_docker = true,
    docker_image = "plantuml/plantuml-server:latest",
    docker_port = 1234,
    docker_remove_on_stop = false,
  },
  config = function(_, opts)
    local plantuml = require("plantuml")
    plantuml.setup(opts)

    vim.api.nvim_create_user_command("PlantumlExportPng", function()
      local source = vim.api.nvim_buf_get_name(0)
      if source == "" or not vim.uv.fs_stat(source) then
        vim.notify("PlantUML: save the diagram before exporting", vim.log.levels.ERROR)
        return
      end

      if vim.fn.executable("curl") == 0 then
        vim.notify("PlantUML: curl is required to export PNG files", vim.log.levels.ERROR)
        return
      end

      local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
      if text:match("^%s*$") then
        vim.notify("PlantUML: cannot export an empty diagram", vim.log.levels.ERROR)
        return
      end

      local config = plantuml.get_config()
      local output = vim.fn.fnamemodify(source, ":r") .. ".png"
      local temporary_output = output .. ".tmp"
      local url = require("plantuml.encoder").encode(text, "http://127.0.0.1:" .. config.docker_port)

      os.remove(temporary_output)
      plantuml.start()
      vim.system({
        "curl",
        "--fail",
        "--silent",
        "--show-error",
        "--retry",
        "30",
        "--retry-connrefused",
        "--retry-delay",
        "1",
        "--output",
        temporary_output,
        url,
      }, { text = true }, function(result)
        vim.schedule(function()
          if result.code ~= 0 then
            os.remove(temporary_output)
            vim.notify("PlantUML: PNG export failed: " .. (result.stderr or "unknown error"), vim.log.levels.ERROR)
            return
          end

          local ok, err = os.rename(temporary_output, output)
          if not ok then
            os.remove(temporary_output)
            vim.notify("PlantUML: could not save PNG: " .. err, vim.log.levels.ERROR)
            return
          end

          vim.notify("PlantUML: exported " .. output, vim.log.levels.INFO)
        end)
      end)
    end, { desc = "Export current PlantUML diagram as PNG" })
  end,
}
