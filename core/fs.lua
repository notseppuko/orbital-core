local FS = {}

local writefile_ =
    writefile
    or (syn and syn.writefile)
    or (sunc and sunc.writefile)

local readfile_ =
    readfile
    or (syn and syn.readfile)
    or (sunc and sunc.readfile)

local isfolder_ =
    isfolder
    or (syn and syn.isfolder)
    or (sunc and sunc.isfolder)

local makefolder_ =
    makefolder
    or (syn and syn.makefolder)
    or (sunc and sunc.makefolder)

FS.supports = {
    writefile = type(writefile_) == "function",
    readfile  = type(readfile_) == "function",
    isfolder  = type(isfolder_) == "function",
    makefolder= type(makefolder_) == "function"
}

function FS.ensureFolder(path)
    if not FS.supports.isfolder or not FS.supports.makefolder then
        return false, "folder API unavailable"
    end

    if not isfolder_(path) then
        local ok, err = pcall(function()
            makefolder_(path)
        end)
        if not ok then
            return false, err
        end
    end

    return true
end

function FS.write(path, data)
    if not FS.supports.writefile then
        return false, "writefile unavailable"
    end

    local ok, err = pcall(function()
        writefile_(path, data)
    end)

    if not ok then
        return false, err
    end

    return true
end

function FS.read(path)
    if not FS.supports.readfile then
        return nil, "readfile unavailable"
    end

    local ok, data = pcall(function()
        return readfile_(path)
    end)

    if not ok then
        return nil, data
    end

    return data
end

return FS
