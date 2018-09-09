
local fs = {}

local function popen (command, n)
    if not n then n = 3 end
    local result, err

    for i = 1, n do
        local file = io.popen(command)
        result, err = file:read("*a")
        file:close()

        if err and err == "Interrupted system call" then
        else
            break
        end
    end

    return result, err
end

function fs.read (path, n)
    local content, err = fs.readFile(path)

    if not content then
        if err == "Is a directory" then
            return fs.readdir(path, n)
        else
            return nil, err
        end
    else
        return content
    end
end

function fs.readdir (path, n)
    local content = popen("ls -a '" .. path .. "'", n)

    if not content or content == "" then
        return nil, "No such file or directory"
    end

    local dir = {}
    local i = 0
    local start = 1
    while true do
        i = string.find(content, "\n", i + 1)
        if i == nil then 
            break
        else
            local file = string.sub(content, start, i - 1)
            start = i + 1

            if file ~= "." and file ~= ".." then
                table.insert(dir, file)
            end
        end
    end

    return dir
end

function fs.readFile (path)
    local file, err = io.open(path)

    if not file then
        return nil, err
    end

    local content, err = file:read("*a")

    if not content then
        file:close()
        return nil, err
    end

    file:close()
    return content, err
end

function fs.writeFile (path, content)
    local file, err = io.open(path, "w+")

    if not file then
        return false, err
    end

    local ok, err = file:write(content)

    if not ok then
        file:close()
        return false, err
    end

    file:close()
    return true, err
end

fs.write = fs.writeFile

function fs.realpath (path, n)
    if not path or path == "" then
        return nil, "path is required"
    end

    local _path = popen("realpath '" .. path .. "'", n)

    return string.sub(_path, 1, string.len(_path) - 1)
end

function fs.exists (path)
    local file, err = io.open(path)

    if not file then
        return false
    else
        return true
    end
end

function fs.copy (path1, path2)
    local content, err = fs.read(path1)

    if not content then
        return false, err
    end

    local ok, err = fs.write(path2, content)

    if not ok then
        return false, err
    end

    return true
end

function fs.move (path1, path2)
    local content, err = fs.read(path1)

    if not content then
        return false, err
    end

    local ok, err = fs.write(path2, content)

    if not ok then
        return false, err
    end

    return true
end

function fs.mkdir (path)
end

function fs.rm (path)
end

function fs.rmdir (path)
end

function fs.unlink (path)
end

function fs.rmAll (path)
end

function fs.chown (path)
end

function fs.chmod (path)
end

function fs.tmpfile (path)
end

function fs.isDir (path)
    local file = io.open(path)

    if not file then
        return false
    end

    local content, err = file:read(0)
    file:close()

    if not content and err == "Is a directory" then
        return true
    else
        return false
    end
end

function fs.isFile (path)
    local file = io.open(path)

    if not file then
        return false
    end

    local content = file:read(0)
    file:close()

    if not content then
        return false
    else
        return true
    end
end

return fs
