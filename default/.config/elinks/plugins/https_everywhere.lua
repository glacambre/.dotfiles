
https_filename = elinks_home .. "/https_domain_rules"

https = {}
file = io.open(https_filename, "r")
if f ~= nil then
    for line in file:lines() do
        https[string.sub(line, 3)] = string.sub(line, 1, 1)
    end
    io.close(file)
else
    file = io.open(https_filename, "w")
    io.output(file)
    io.write("hello")
    io.close(file)
end

-- Returns true if str1 begins with str2
function beginswith (str1, str2)
    return string.sub(str1, 1, string.len(str2)) == str2
end

-- Extracts the domain name out of an url
function extract_domain (url)
    -- Remove protocol
    url = string.sub(url, 8)
    -- Return the domain name without its file descriptor
    return string.sub(url, 1, (string.find(url, "/") or 0) - 1)
end

-- Try to make everything go https
function follow_url_hook (url)
    -- Is this an http request ?
    if beginswith(url, "http:")  == false then
        return url
    end

    local domain = extract_domain(url)

    if https[domain] == 1 then -- We know that the domain has https
        return "https" .. string.sub(url, 5)
    elseif https[domain] == 0 then -- We know https isn't available
        return url
    end

    local tcp = assert(require("socket").tcp())
    tcp:connect(domain, 443)
    tcp:send("GET / HTTP/1.1\nHost: " .. domain .. "\nAccept: */*\n\n")
    local str, status, partial = tcp:receive()
    -- print(str, status, partial)
    tcp:close()
    if str == nil then -- Socket isn't open, https isn't available
        https[domain] = 0
        return url
    end

    https[domain] = 1
    return "https" .. string.sub(url, 5)
end

-- Save the https table to a file
function quit_hook ()
    local file = io.open(https_filename, "w")
    io.output(file)
    for domain, value in pairs(https) do
        io.write(value .. " " .. domain .. "\n")
    end
    io.close(file)
end
