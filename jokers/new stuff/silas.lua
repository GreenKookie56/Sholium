
SMODS.Joker{ --Silas (v50)
    key = "silas",
    config = {
        extra = {
            mult = 4
        }
    },
    loc_txt = {
        ['name'] = 'Silas (v50)',
        ['text'] = {
            [1] = 'Creates an {C:attention}Icicle{} when',
            [2] = 'a booster pack is skipped',
            [3] = 'All Icicles and Icicle alts give {C:red}+#1#{} Mult',
            [4] = '{C:inactive}ski buddy silas{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    
    calculate = function(self, card, context)
        if context.skipping_booster or context.forcetrigger then
            return {
                func = function()
                    
                    local created_joker = false
                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        created_joker = true
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_iciclez' })
                                if joker_card then
                                    
                                    
                                end
                                G.GAME.joker_buffer = 0
                                return true
                            end
                        }))
                    end
                    if created_joker then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
                    end
                    return true
                end
            }
        end
        if context.other_joker  then
            if (context.other_joker.config.center.key == "j_sholium_iciclez" or context.other_joker.config.center.key == "j_sholium_iciclezalt") then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}