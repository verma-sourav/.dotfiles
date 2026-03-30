-- This logic to run Go tests was extracted from https://github.com/crispgm/nvim-go. All I really
-- want is the testing commands and not everything else, so this extracts just the testing stuff.
-- The specific commit was a665d79ba394e4bc7398c866ca603ebddae28641
local M = {}

local function show_warning(prefix, msg)
    vim.api.nvim_echo({ { prefix, "WarningMsg" }, { " " .. msg } }, true, {})
end

local function show_error(prefix, msg)
    vim.api.nvim_echo({ { prefix, "ErrorMsg" }, { " " .. msg } }, true, {})
end

local function go_exists()
    local exists = vim.fn.executable("go") == 1
    if not exists then
        show_error("No Binary", "Go is not installed")
    end
    return exists
end

local function build_args(args, opts)
    opts = opts or {}

    table.insert(args, "-timeout=30s")
    if opts.verbose then
        table.insert(args, "-v")
    end

    -- Redirect stderr to stdout so neovim won't crash (crispgm/nvim-go #12)
    table.insert(args, "2>&1")
    return table.concat(args, " ")
end

local function valid_func_name(func_name)
    return func_name and (vim.startswith(func_name, "Test") or vim.startswith(func_name, "Example"))
end

local function split_file_name(str)
    return vim.fn.split(vim.fn.split(str, " ")[2], "(")[1]
end

local function valid_buf()
    local buf_nr = vim.api.nvim_get_current_buf()
    return vim.api.nvim_buf_is_valid(buf_nr) and vim.api.nvim_get_option_value("buflisted", { buf = buf_nr })
end

local function do_test(prefix, cmd)
    if not valid_buf() then
        return
    end

    local function on_event(_, data, event)
        local outputs = {}
        for _, v in ipairs(data) do
            if string.len(v) > 0 then
                table.insert(outputs, v)
            end
        end

        if #outputs > 0 then
            M.show_output(outputs)
        end
    end

    local cwd = vim.fn.expand("%:p:h")
    local opts = {
        on_exit = function(_, code, _)
            if code ~= 0 then
                show_warning(prefix, string.format("error code: %d", code))
            end
        end,
        cwd = cwd,
        on_stdout = on_event,
        on_stderr = on_event,
        stdout_buffered = true,
        stderr_buffered = true,
    }
    vim.fn.jobstart(cmd, opts)
end

function M.test(opts)
    if not go_exists() then
        return
    end

    local prefix = "GoTest"
    local cmd = { "go", "test" }
    do_test(prefix, build_args(cmd, opts))
end

function M.test_all(opts)
    if not go_exists() then
        return
    end

    local prefix = "GoTestAll"
    local cmd = { "go", "test", "./..." }
    do_test(prefix, build_args(cmd, opts))
end

function M.test_func(opts)
    if not go_exists() then
        return
    end

    local prefix = "GoTestFunc"
    local func_name = ""
    local line = vim.fn.search([[func \(Test\|Example\)]], "bcnW")
    if line == 0 then
        show_error(prefix, string.format("Test func not found: %s", func_name))
        return
    end
    local cur_line = vim.fn.getline(line)
    func_name = split_file_name(cur_line)
    if not valid_func_name(func_name) then
        show_error("GoTestFunc", string.format("Invalid test func: %s", func_name))
        return
    end
    func_name = vim.fn.shellescape(string.format("^%s$", func_name))

    local cmd = {
        "go",
        "test",
        "-run",
        func_name,
    }
    do_test(prefix, build_args(cmd, opts))
end

function M.test_file(opts)
    if not go_exists() then
        return
    end

    local prefix = "GoTestFile"
    local pattern = vim.regex("^func [Test|Example]")
    local lines = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 1, -1, false)
    local func_names = {}
    if #lines == 0 then
        return
    end
    for _, line in ipairs(lines) do
        local col_from, _ = pattern:match_str(line)
        if col_from then
            local fn = split_file_name(line)
            if valid_func_name(fn) then
                table.insert(func_names, fn)
            end
        end
    end
    local cmd = {
        "go",
        "test",
        "-run",
        vim.fn.shellescape(string.format("^%s$", table.concat(func_names, "|"))),
    }
    do_test(prefix, build_args(cmd, opts))
end

function M.show_output(lines)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q!<cr>", { noremap = true, silent = true })

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })
end

return M
