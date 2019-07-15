
exec_couples = {
    { url = "https://w?w?w?%.?youtu.be/.*", exec = "mpv %s &" },
    { url = "https://w?w?w?%.?youtube.com/watch%?v=.*", exec = "mpv %s &" },
}

function follow_url_hook (url)

    for i = 1, #exec_couples do
        if string.match(url, exec_couples[i].url) then
            local execstr = string.format(exec_couples[i].exec, "'" .. url .. "'")
            execute(execstr);
            return url
        end
    end

    return url
end

