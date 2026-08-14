-- paths to check for project.godot file
local paths_to_check = {'/', '/../'}
local is_godot_project = false
local godot_project_path = ''
local cwd = vim.fn.getcwd()

-- iterate over paths and check
for key, value in pairs(paths_to_check) do
    if vim.uv.fs_stat(cwd .. value .. 'project.godot') then
        is_godot_project = true
        godot_project_path = vim.fn.fnamemodify(cwd .. value, ':p'):gsub('[/\\]+$', '')
        break
    end
end

if is_godot_project then
    local pipe_addr
    if vim.fn.has('win32') == 1 then
        pipe_addr = '\\\\.\\pipe\\godot-nvim-' .. godot_project_path:gsub('[%s:\\/]', '-')
    else
        pipe_addr = godot_project_path .. '/server.pipe'
    end

    local already_serving = false
    for _, addr in ipairs(vim.fn.serverlist()) do
        if addr == pipe_addr then
            already_serving = true
            break
        end
    end

    if not already_serving then
        local ok, err = pcall(vim.fn.serverstart, pipe_addr)
        if not ok then
            vim.notify('godot.lua: failed to start server on ' .. pipe_addr .. ': ' .. tostring(err), vim.log.levels.WARN)
        end
    end
end
