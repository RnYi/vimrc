----------------------------
--  Aliases for Nvim API  --
----------------------------
local g = vim.g
local opt = vim.opt

-------------
--  Basic  --
-------------
opt.mouse = 'nvi'
opt.mousemodel = 'extend'
opt.backup = false
opt.writebackup = false
opt.autoread = true
opt.winaltkeys = 'no'
opt.backspace = { 'indent', 'eol', 'start' }
opt.ttimeout = true
opt.ttimeoutlen = 100
opt.updatetime = 300
opt.foldmethod = 'manual'
-- opt.switchbuf = {'usetab','newtab'}
-- Persistent undo
opt.undofile = true
-- Search path of tags file
opt.tags = { './.tags;', '.tags' }
-- Font
opt.guifont = "FiraCode NFM:h13"
opt.guifontwide = '黑体:h13'
opt.lazyredraw = true
-- Diff
opt.diffopt:append('vertical')
-- Grepper
opt.grepprg = 'rg --vimgrep'
-- Specify tex filetype
g.tex_flavor = 'latex'
-- Language support
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python_provider = 0
g.python3_host_prog = 'python3'
-- disable internal plugins
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-----------
-- Shell --
-----------
-- if OSName == 'win' then
--     opt.shell = g.pwsh_path
--     opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
--     opt.shellredir='2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
--     opt.shellpipe='2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
--     opt.shellquote = ''
--     opt.shellxquote = ''
-- end

--------------
--  Indent  --
--------------
-- opt.tabstop=4
opt.shiftwidth = 4
opt.softtabstop = -1
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true

----------------
--  Encoding  --
----------------
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.fileencodings = { 'utf-8', 'usc-bom', 'chinese', 'gb18030', 'gbk', 'gb2312', 'cp936' }

---------------
--  Display  --
---------------
opt.wrap = true
opt.number = true
opt.showcmd = false
opt.pumheight = 20
opt.signcolumn = 'yes'
opt.title = true
opt.titlestring = '%{getcwd()}'
opt.hidden = true
opt.wildmenu = true
opt.showmode = true
opt.cursorline = true
opt.showtabline = 2
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.laststatus = 2
opt.termguicolors = true
opt.shortmess = { a = true, o = true, O = true, c = true, t = true, T = true, F = true }
opt.formatoptions = { t = true, c = true, r = true, q = true, l = true, m = true, M = true, j = true }
opt.list = true
-- opt.showbreak='↪'
opt.listchars = { trail = '·', extends = '⟩', precedes = '⟨' }
vim.cmd([[
set matchpairs+=「:」,『:』,【:】,“:”,‘:’,《:》,（:）
]])

--------------
--  Search  --
--------------
opt.wrapscan = true
opt.smartcase = true
opt.incsearch = true
opt.ignorecase = true

---------------
--  Session  --
---------------
opt.viewoptions:remove('options')
opt.sessionoptions:remove('blank')
opt.sessionoptions:remove('winpos')
opt.sessionoptions:remove('terminal')
opt.sessionoptions:remove('options')
opt.sessionoptions:remove('help')

---------------
--  Autocmd  --
---------------
local function resume_cursor_pos(ev)
    local ignore_buftype = { 'quickfix', 'nofile', 'help' }
    local ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcyommit' }
    -- ignore buftypes
    if vim.tbl_contains(ignore_buftype, vim.api.nvim_buf_get_option(0, 'buftype')) then
        return
    end
    -- ignore filetypes
    if vim.tbl_contains(ignore_filetype, vim.api.nvim_buf_get_option(0, 'filetype')) then
        vim.api.nvim_command([[normal! gg]])
        return
    end
    if vim.fn.line('.') > 1 then
        return
    end
    -- resume cursor position
    local last_line = vim.fn.line([['"]])
    local buff_last_line = vim.fn.line('$')
    local window_last_line = vim.fn.line('w$')
    local window_first_line = vim.fn.line('w0')
    if last_line > 0 and last_line <= buff_last_line then
        if window_last_line == buff_last_line then
            vim.api.nvim_command([[normal! g`"]])
        elseif buff_last_line - last_line > ((window_last_line - window_first_line) / 2) - 1 then
            vim.api.nvim_command([[normal! g`"zz]])
        else
            vim.api.nvim_command([[normal! zvzz]])
        end
    end
end

vim.api.nvim_create_augroup('UserFileAug', {})
--  Resume cursor position
vim.api.nvim_create_autocmd('BufRead', {
    group = 'UserFileAug',
    pattern = '*',
    callback = resume_cursor_pos,
})
-- Surpress error in markdown
vim.api.nvim_create_autocmd('FileType', {
    group = 'UserFileAug',
    pattern = 'markdown',
    callback = function(ev)
        vim.api.nvim_set_hl(0, 'Error', {})
    end
})
vim.api.nvim_create_augroup('UserTermAug', {})
-- Term autocmds
vim.api.nvim_create_autocmd({ 'TermOpen', 'TermEnter', 'TermLeave' }, {
    group = 'UserTermAug',
    pattern = '*',
    callback = function(ev)
        if ev.event == 'TermOpen' then
            vim.api.nvim_command('startinsert')
        elseif ev.event == 'TermEnter' then
            vim.opt_local.number = false
        else
            vim.opt_local.number = true
        end
    end
})
vim.api.nvim_create_augroup('UserSearchAug', {})
vim.api.nvim_create_autocmd({ 'CmdlineEnter', 'CmdlineLeave' }, {
    group = 'UserSearchAug',
    pattern = { '/', '?' },
    callback = function(ev)
        if ev.event == 'CmdlineEnter' then
            vim.o.hlsearch = true
        else
            vim.o.hlsearch = false
        end
    end
})
