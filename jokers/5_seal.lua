SMODS.Joker{ --Blue Seal
    key = "sealblue",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Blue Seal',
        ['text'] = {
            [1] = '{C:attention}-1{} Hand size',
            [2] = 'Creates the {C:planet}Planet{} card of',
            [3] = 'last played {C:attention}poker hand{}',
            [4] = 'at end of round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval or context.forcetrigger then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    if G.GAME.last_hand_played then
                        local _planet = nil
                        for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                            if v.config.hand_type == G.GAME.last_hand_played then
                                _planet = v.key
                            end
                        end
                        if _planet then
                            local planet_card = SMODS.add_card({ key = _planet })
                        end
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end
            }))
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(-1)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(1)
    end
}
SMODS.Joker{ --Gold Seal
    key = "sealgold",
    config = {
        extra = {
            dollars = 3
        }
    },
    loc_txt = {
        ['name'] = 'Gold Seal',
        ['text'] = {
            [1] = '{C:attention}-1{} Hand size',
            [2] = 'Earn {C:gold}$#1#{} when a hand is played'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)

        return {vars = {card.ability.extra.dollars}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    dollars = card.ability.extra.dollars
                }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(-1)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(1)
    end
}
SMODS.Joker{ --Purple Seal
    key = "sealpurple",
    config = {
        extra = {
            Tarot = 0
        }
    },
    loc_txt = {
        ['name'] = 'Purple Seal',
        ['text'] = {
            [1] = '{C:attention}-1{} Hand size',
            [2] = 'Create a random {C:tarot}Tarot{}',
            [3] = 'when a hand is discarded'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.pre_discard or context.forcetrigger then
                return {
                    func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Tarot', key = nil, key_append = 'joker_forge_tarot'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                    end
                    return true
                end
                }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(-1)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(1)
    end
}
SMODS.Joker{ --Red Seal
    key = "sealred",
    config = {
        extra = {
            repetitions = 1
        }
    },
    loc_txt = {
        ['name'] = 'Red Seal',
        ['text'] = {
            [1] = '{C:attention}-1{} Hand size',
            [2] = 'Retrigger all played cards'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = localize('k_again_ex')
                }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(-1)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(1)
    end
}
