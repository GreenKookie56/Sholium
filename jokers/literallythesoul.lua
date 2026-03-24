
SMODS.Joker{ --Literally The Soul
    key = "literallythesoul",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Literally The Soul',
        ['text'] = {
            [1] = 'Creates a {C:legendary}Legendary{} Joker',
            [2] = 'and {C:red}self-destruct{} when',
            [3] = '{C:attention}Boss Blind{} is defeated'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = false,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss and not context.blueprint then
            return {
                func = function()
                    local target_joker = card
                    if target_joker then
                        target_joker.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                return true
                            end
                        }))
                    end
                    return true
                end,
                extra = {
                    func = function()
                        local created_joker = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local joker_card = SMODS.add_card({ set = 'Joker', rarity = 'Legendary' })
                                if joker_card then
                                end
                                return true
                            end
                        }))
                        if created_joker then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
                        end
                        return true
                    end,
                    colour = G.C.BLUE
                }
            }
        end
        if context.forcetrigger then
            return {
                func = function()
                    local created_joker = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local joker_card = SMODS.add_card({ set = 'Joker', rarity = 'Legendary' })
                            if joker_card then 
                            end
                            return true
                        end
                    }))
                    if created_joker then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
                    end
                    return true
                end
            }
        end
    end
}
