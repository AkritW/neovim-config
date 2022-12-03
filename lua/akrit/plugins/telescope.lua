local telescopesetup, telescope = pcall(require, "telescope")
if not telescopesetup then
    return
end

local actionsetup, action = pcall(require, "telescope.setup")
if not actionsetup then
    return
end

telescope.setup({
    defaults = {
        mapping = {
            i = {
                ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                ["<C-j>"] = actions.move_selection_next, -- move to next result
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
            }
        }
    }
})

telescope.load_extension("fzf")
