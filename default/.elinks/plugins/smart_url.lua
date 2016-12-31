
supported_protocols = {"http", "https", "ftp", "bittorent", "gopher", "smb", "nntp"}
keywords = {
    ddg     = "https://duckduckgo.com/?q=%s",
    deb     = "https://packages.debian.org/search?keywords=%s&searchon=names&suite=all&section=all",
    g       = "https://encrypted.google.com/search?q=%s",
    github  = "https://github.com/search?q=%s",
    i       = "https://encrypted.google.com/search?q=%s&tbm=isch",
    s       = "http://searx.me/?q=%s&category_general=on",
    w       = "https://en.wikipedia.org/wiki/%s",
    wfr     = "https://fr.wikipedia.org/wiki/%s",
    y       = "https://www.youtube.com/results?search_type=search_videos&search_query=%s&search_sort=relevance&search_category=0",
}
default_engine = "s"

-- Returns true if str1 begins with str2
function beginswith (str1, str2)
    return string.sub(str1, 1, string.len(str2)) == str2
end

-- Try to be smart when opening a new page through the form
function goto_url_hook (url, current_url)
    -- Try keyword matching
    for key, value in pairs(keywords) do
        if beginswith(url, key .. " ") then
            return string.format(value, string.sub(url, string.len(key) + 1))
        end
    end

    -- Try protocol matching
    for i = 1, #supported_protocols do
        if beginswith(url, supported_protocols[i] .. "://") then
            return url
        end
    end

    -- Does the query look like an URL ?
    local pattern = "^%w+%.?%w*%.?%w*%.%w%w+"
    if string.match(url, pattern) ~= nil then
        return url
    end

    -- Perhaps we're trying to load a local file
    if string.sub(url, 1, 1) == "/" then
        return url
    end

    -- Maybe a local file relative to our $HOME ?
    if string.sub(url, 1, 1) == "~" then
        return os.getenv("HOME") .. string.sub(url, 2)
    end

    -- Do a regular search query using the default search engine
    return string.format(keywords[default_engine], url)
end

