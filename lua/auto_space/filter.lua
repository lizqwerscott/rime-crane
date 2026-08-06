-- 候选词自动空格：
-- 1. 处理同一候选内部，如「iPad很好」→「iPad 很好」；
-- 2. 根据上次上屏文本处理跨候选边界，如「使用」+「iPad」。
--
-- 必须放在 search 辅码过滤之后、uniquifier 之前；否则前导空格会导致
-- 小鹤音形 fn/bm 辅码无法用原始候选文字做匹配。

local common = require("auto_space.common")
local filter = {}

function filter.func(input, env)
    if not env.engine.context:get_option("auto_space") then
        for cand in input:iter() do yield(cand) end
        return
    end

    local latest_text = env.engine.context.commit_history:latest_text()
    local previous_category = common.last_category(latest_text)

    for cand in input:iter() do
        local text = common.add_inner_spaces(cand.text)
        if common.needs_space(previous_category, common.first_category(text)) then text = " " .. text end

        if text ~= cand.text then
            cand = cand:to_shadow_candidate("auto_space", text, cand.comment)
        end
        yield(cand)
    end
end

return filter
