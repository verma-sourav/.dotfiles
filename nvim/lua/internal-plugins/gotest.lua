local M = {}

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

    return args
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

local function do_test(cmd)
    if not valid_buf() then
        return
    end

    -- Capture the buffer directory before creating and focusing on the scratch buffer and window
    local cwd = vim.fn.expand("%:p:h")
    local buf, win = M.create_window()

    local function append_data(_, data)
        if not data or data == "" then
            return
        end

        local lines = vim.split(data, "\n", { plain = true })
        vim.schedule(function()
            vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_set_cursor(win, { vim.api.nvim_buf_line_count(buf), 0 })
            end
        end)
    end

    local function on_exit(result)
        local ec = result.code
        if ec == 0 then
            append_data(nil, "PASSED")
        else
            append_data(nil, "FAILED (exit code: " .. ec .. ")")
        end
    end

    append_data(nil, "Running command: " .. table.concat(cmd, " "))
    vim.system(cmd, {
        cwd = cwd,
        text = true,
        stdout = append_data,
        stderr = append_data,
    }, on_exit)
end

function M.test(opts)
    if not go_exists() then
        return
    end

    local cmd = { "go", "test" }
    do_test(build_args(cmd, opts))
end

function M.test_all(opts)
    if not go_exists() then
        return
    end

    local cmd = { "go", "test", "./..." }
    do_test(build_args(cmd, opts))
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

    local cmd = {
        "go",
        "test",
        "-run",
        string.format("^%s$", func_name),
    }
    do_test(build_args(cmd, opts))
end

function M.test_file(opts)
    if not go_exists() then
        return
    end

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
        string.format("^%s$", table.concat(func_names, "|")),
    }
    do_test(build_args(cmd, opts))
end

function M.create_window()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q!<cr>", { noremap = true, silent = true })

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    return buf, win
end

function M.setup()
    local group = vim.api.nvim_create_augroup("GoTest", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        desc = "Add commands for running Go tests",
        group = group,
        callback = function(o)
            local buf = o.buf

            vim.api.nvim_buf_create_user_command(buf, "GoTest", function(opts)
                M.test({ verbose = opts.args == "verbose" })
            end, { nargs = "?" })

            vim.api.nvim_buf_create_user_command(buf, "GoTestAll", function(opts)
                M.test_all({ verbose = opts.args == "verbose" })
            end, { nargs = "?" })

            vim.api.nvim_buf_create_user_command(buf, "GoTestFile", function(opts)
                M.test_file({ verbose = opts.args == "verbose" })
            end, { nargs = "?" })

            vim.api.nvim_buf_create_user_command(buf, "GoTestFunc", function(opts)
                M.test_func({ verbose = opts.args == "verbose" })
            end, { nargs = "?" })
        end,
    })
end

return M
