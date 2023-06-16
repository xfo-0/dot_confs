------------------------------------
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--   operator pending = "e",
local map = vim.keymap.set
local del = vim.keymap.del
------------------------------------
-- Normal  {{{

map("n", "<cr>", "ciw", { silent = true })
map("n", "<C-cr>", "ciq", { silent = true })
map("n", "<M-cr>", "cib", { silent = true })

-- del("n", "")
map("n", "<M-Esc>", ":close!<cr>", { silent = true })
map("n", "<M-C-Up>", ":lua require('Navigator').up()<cr>", { silent = true })
map("n", "<M-C-Down>", ":lua require('Navigator').down()<cr>", { silent = true })
map("n", "<M-C-Left>", ":lua require('Navigator').left()<cr>", { silent = true })
map("n", "<M-C-Right>", ":lua require('Navigator').right()<cr>", { silent = true })

-- Resize with arrows
map("n", "<M-S-e>", ":resize +2<cr>", { silent = true })
map("n", "<M-S-t>", ":resize -2<cr>", { silent = true })
map("n", "<M-S-o>", ":vertical resize -2<cr>", { silent = true })
map("n", "<M-S-n>", ":vertical resize +2<cr>", { silent = true })

-- Navigate ::hbuffers
map("n", "<M-o>", ":BufferLineCyclePrev<cr>", { silent = true })
map("n", "<M-n>", ":BufferLineCycleNext<cr>", { silent = true })
map("n", "<M-r>", ":bdelete<cr>", { silent = true })

-- move buffers
map("n", "<M-e>", ":BufferLineMovePrev<cr>", { silent = true })
map("n", "<M-t>", ":BufferLineMoveNext<cr>", { silent = true })
-- map("n", "<C-Right>", "<Plug>(CybuPrev)", opts)
-- map("n", "<C-Left>", "<Plug>(CybuNext)", opts)

-- Home End remap
map("n", "<End>", "$")
map("n", "<Home>", "0")

--    }}}
------------------------------------
-- Insert  {{{
-- Press jk fast to enter
map("i", "jk", "<ESC>")

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
--    }}}
------------------------------------
-- Visual  {{{
vim.api.nvim_set_keymap("v", "t", "<Plug>(leap-forward)", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "T", "<Plug>(leap-backward)", { noremap = true, silent = true })

-- yank without cursor reset
vim.api.nvim_set_keymap("v", "y", "ygv<esc>", { silent = true })

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Home End remap
map("v", "<End>", "$")
map("v", "<Home>", "0")

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP')

vim.cmd [[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call g:VSetSearch('/')<cr>/<C-R>=@/<cr><cr>
  xnoremap # :<C-u>call g:VSetSearch('?')<cr>?<C-R>=@/<cr><cr>
]]
--    }}}
------------------------------------
-- Visual Block  {{{

map("x", "n", "'Nn'[v:searchforward]", { expr = true })
map("x", "N", "'nN'[v:searchforward]", { expr = true })

-- Home End remap
map("x", "^[[4~", "$")
map("x", "^[[1~", "0")
-- map("x", "<ESC>OF", "$", opts)
-- map("x", "<ESC>OH", "0", opts)

-- -- treehopper
-- map("x", "gt", ":lua require('tsht').nodes()<cr>")
--    }}}
------------------------------------
-- Pending  {{{
map("o", "n", "'Nn'[v:searchforward]", { expr = true })
map("o", "N", "'nN'[v:searchforward]", { expr = true })
-- -- treehopper
-- map("o", "gt", ":<C-U>lua require('tsht').nodes()<cr>")
--    }}}
------------------------------------
map({ "o", "x" }, "ii", "<cmd>lua require('various-textobjs').indentation(true, true)<CR>")
map({ "o", "x" }, "ai", "<cmd>lua require('various-textobjs').indentation(false, true)<CR>")
map({ "o", "x" }, "iI", "<cmd>lua require('various-textobjs').indentation(true, true)<CR>")
map({ "o", "x" }, "aI", "<cmd>lua require('various-textobjs').indentation(false, false)<CR>")

map({ "o", "x" }, "iS", "<cmd>lua require('various-textobjs').subword(true)<CR>")
map({ "o", "x" }, "aS", "<cmd>lua require('various-textobjs').subword(false)<CR>")

-- map({ "o", "x" }, "%", "<cmd>lua require('various-textobjs').toNextClosingBracket()<CR>")

map({ "o", "x" }, "R", "<cmd>lua require('various-textobjs').restOfParagraph()<CR>")

map({ "o", "x" }, "<M-v>", "<cmd>lua require('various-textobjs').entireBuffer()<CR>")

map({ "o", "x" }, "n", "<cmd>lua require('various-textobjs').nearEoL()<CR>")

map({ "o", "x" }, "_", "<cmd>lua require('various-textobjs').lineCharacterwise()<CR>")

map({ "o", "x" }, "|", "<cmd>lua require('various-textobjs').column()<CR>")

map({ "o", "x" }, "iv", "<cmd>lua require('various-textobjs').value(true)<CR>")
map({ "o", "x" }, "av", "<cmd>lua require('various-textobjs').value(false)<CR>")

map({ "o", "x" }, "ik", "<cmd>lua require('various-textobjs').key(true)<CR>")
map({ "o", "x" }, "ak", "<cmd>lua require('various-textobjs').key(false)<CR>")

map({ "o", "x" }, "L", "<cmd>lua require('various-textobjs').url()<CR>")

map({ "o", "x" }, "!", "<cmd>lua require('various-textobjs').diagnostic()<CR>")

map({ "o", "x" }, "iz", "<cmd>lua require('various-textobjs').closedFold(true)<CR>")
map({ "o", "x" }, "az", "<cmd>lua require('various-textobjs').closedFold(false)<CR>")

map({ "o", "x" }, "im", "<cmd>lua require('various-textobjs').chainMember(true)<CR>")
map({ "o", "x" }, "am", "<cmd>lua require('various-textobjs').chainMember(false)<CR>")

--------------------------------------------------------------------------------------

-- filetype specific text object mappings
-- keymap(
-- 	{ "o", "x" },
-- 	"YOUR_MAPPING",
-- 	"<cmd>lua require('various-textobjs').mdlink(true)<CR>",
-- 	{ nuffer = true }
-- )
-- keymap(
-- 	{ "o", "x" },
-- 	"YOUR_MAPPING",
-- 	"<cmd>lua require('various-textobjs').mdlink(false)<CR>",
-- 	{ buffer = true }
-- )

-- keymap(
-- 	{ "o", "x" },
-- 	"YOUR_MAPPING",
-- 	"<cmd>lua require('various-textobjs').mdFencedCodeBlock(true)<CR>",
-- 	{ buffer = true }
-- )
-- keymap(
-- 	{ "o", "x" },
-- 	"YOUR_MAPPING",
-- 	"<cmd>lua require('various-textobjs').mdFencedCodeBlock(false)<CR>",
-- 	{ buffer = true }
-- )

-- keymap(
-- 	{ "o", "x" },
-- 	"YOUR_MAPPING",
-- 	"<cmd>lua require('various-textobjs').cssSelector(true)<CR>",
-- 	{ buffer = true }
-- )
-- keymap(
-- 	{ "o", "x" },
-- 	"YOUR_MAPPING",
-- 	"<cmd>lua require('various-textobjs').cssSelector(false)<CR>",
-- 	{ buffer = true }
-- )

-- keymap(
-- 	{ "o", "x" },
-- 	"YOUR_MAPPING",
-- 	"<cmd>lua require('various-textobjs').htmlAttribute(true)<CR>",
-- 	{ buffer = true }
-- )
-- keymap(
-- 	{ "o", "x" },
-- 	"YOUR_MAPPING",
-- 	"<cmd>lua require('various-textobjs').htmlAttribute(false)<CR>",
-- 	{ buffer = true }
-- )

-- keymap(
-- 	{ "o", "x" },
-- 	"YOUR_MAPPING",
-- 	"<cmd>lua require('various-textobjs').doubleSquareBrackets(true)<CR>",
-- 	{ buffer = true }
-- )
-- keymap(
-- 	{ "o", "x" },
-- 	"YOUR_MAPPING",
-- 	"<cmd>lua require('various-textobjs').doubleSquareBrackets(false)<CR>",
-- 	{ buffer = true }
-- )

-- keymap(
-- 	{ "o", "x" },
-- 	"YOUR_MAPPING",
-- 	"<cmd>lua require('various-textobjs').shellPipe(true)<CR>",
-- 	{ buffer = true }
-- )
-- keymap(
-- 	{ "o", "x" },
-- 	"YOUR_MAPPING",
-- 	"<cmd>lua require('various-textobjs').shellPipe(false)<CR>",
-- 	{ buffer = true }
-- )
