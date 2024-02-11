-- Script to load sub files when they're stored like this:
-- - directory/
--             episode1.mp4
--             episode2.mp4
--             Subs/
--                  episode1/
--                           2_English.srt
--                           16_French.srt
--                  episode2/
--                           2_English.srt
--                           16_French.srt
-- For some reason MPV is unable to deal with this by default.
-- Copyright glacambre donut steal (but feel free to copy/paste)
local msg = require "mp.msg"
local utils = require "mp.utils"
mp.add_hook("on_load", 50, function()
    local path = mp.get_property_native("path")
    local info = utils.file_info(path)
    if info.is_dir then
        return
    end
    local dir, file = utils.split_path(path)
    local basename = file:match("(.+)%..+$")
    if basename == nil then
        basename = file
    end
    local subs_parent_dir = utils.join_path(dir, "Subs")
    local subs_dir = utils.join_path(subs_parent_dir, basename)
    local sub_files = utils.readdir(subs_dir, "files")
    local slangs = mp.get_property_native("slang")
    local sub_paths = {}
    for _, sub_file in pairs(sub_files) do
        for _, slang in pairs(slangs) do
            if sub_file:lower():find('%d_' .. slang) then
                local sub_path = utils.join_path(subs_dir, sub_file)
                table.insert(sub_paths, sub_path)
                break
            end
        end
    end
    mp.set_property_native("options/sub-files", sub_paths)
end)
