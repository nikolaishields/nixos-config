local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        },
    },
    pickers = {
      file_browser = {
        hidden = true,
      }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
        file_browser = {
            theme = "ivy",
        
        }
    },
})

require("telescope").load_extension("fzy_native")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("projects")

local M = {}
M.search_src = function()
    require("telescope.builtin").find_files({
        prompt_title = "< Projects >",
        cwd = "$HOME/src/github.com",
        hidden = false,
    })
end

M.search_nixos_config = function()
    require("telescope.builtin").find_files({
        prompt_title = "< nixos config >",
        cwd = "$HOME/src/github.com/nikolaishields/nixos-config",
        hidden = false,
    })
end
return M
