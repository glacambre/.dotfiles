
elinks_home = elinks_home or "."

PM_hooks = {
    goto_url_hook        = {},
    follow_url_hook      = {},
    pre_format_html_hook = {},
    proxy_for_hook       = {},
    lua_console_hook     = {},
    quit_hook            = {},
}

-- Old version, will be used later. Based on code shamefully stolen from
-- Niklas Frykholm (http://lua-users.org/wiki/DetectingUndefinedVariables)
--
-- function PM_on_declaration (t, k, v)
--     for key, value in pairs(PM_hooks) do
--         if k == key then
--             PM_hooks[k][#PM_hooks + 1] = v
--             break
--         end
--     end
-- end

-- function PM_grab_declarations ()
--     local mt = getmetatable(_G) or {}
--     mt.__newindex = PM_on_declaration
--     setmetatable(_G, mt)
-- end

-- function PM_release_declarations ()
--     local mt = getmetatable(_G) or {}
--     mt.__newindex = rawset
--     setmetatable(_G, mt)
-- end

-- function PM_load (str)
--     PM_grab_declarations()
--     require(str)
--     PM_release_declarations()
-- end

function PM_load (plugin)
    require("plugins/" .. plugin)
    for key, value in pairs(PM_hooks) do
        if _G[key] ~= nil then
            table.insert(value, _G[key])
            _G[key] = nil
        end
    end
end

function PM_enable ()
    function goto_url_hook (url, current_url)
        for i = 1, #PM_hooks["goto_url_hook"] do
            url = PM_hooks["goto_url_hook"][i](url, current_url)
            if url == "" or url == nil then
                return url
            end
        end
        return url
    end

    function follow_url_hook (url)
        for i = 1, #PM_hooks["follow_url_hook"] do
            url = PM_hooks["follow_url_hook"][i](url)
            if url == "" or url == nil then
                return url
            end
        end
        return url
    end

    function pre_format_html_hook (url, html)
        local original = html
        for i = 1, #PM_hooks["pre_format_html_hook"] do
            html = PM_hooks["pre_format_html_hook"][i](url, html)
            if html == "" then
                return html
            end
        end
        if original == html then
            return nil
        end
        return html
    end

    function proxy_for_hook (url)
        if #PM_hooks["proxy_for_hook"] == 0 then
            return nil
        end
        return PM_hooks["proxy_for_hook"][1](url)
    end

    function lua_console_hook (string)
        if #PM_hooks["lua_console_hook"] == 0 then
            return nil
        end
        return PM_hooks["lua_console_hook"][1](url)
    end

    function quit_hook ()
        for i = 1, #PM_hooks["quit_hook"] do
            PM_hooks[quit_hook]()
        end
    end

end
