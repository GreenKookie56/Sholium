SMODS.Joker{ --Brickell
    key = "brickell",
    config = {
        extra = {
            Mult = 1,
            increasement = 2
        }
    },
    loc_txt = {
        ['name'] = 'Brickell',
        ['text'] = {
            [1] = '{X:red,C:white}X#2#{} Mult every {C:attention}reroll{}',
            [2] = 'resets at end of round',
            [3] = '{C:inactive}(Currently {}{X:red,C:white}X#1#{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 1
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Mult, card.ability.extra.increasement}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
                return {
                    Xmult = card.ability.extra.Mult
                }
        end
        if context.reroll_shop  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.Mult = (card.ability.extra.Mult) + card.ability.extra.increasement
                    return true
                end,
                    message = localize('k_upgrade_ex')
                }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.Mult = 1
                    return true
                end
                }
        end
        if context.forcetrigger then
            local mult_value = card.ability.extra.Mult
            card.ability.extra.Mult = (card.ability.extra.Mult) + card.ability.extra.increasement
            return {
                Xmult = mult_value
            }
        end
    end
}
SMODS.Joker{ --Corvus (v43-48)
    key = "corvus",
    config = {
        extra = {
            Remaining = 2,
            chips = 8000,
            Spectral = 0
        }
    },
    loc_txt = {
        ['name'] = 'Corvus (v43-48)',
        ['text'] = {
            [1] = 'Create an {C:spectral}Immolate{}',
            [2] = 'every {C:attention}3{} played hands',
            [3] = '{C:inactive}#1# remaining{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 4,
        y = 1
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
    soul_pos = {
        x = 5,
        y = 1
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Remaining}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  and not context.blueprint then
            if (card.ability.extra.Remaining or 0) <= 0 then
                local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Spectral', key = 'c_immolate', key_append = 'joker_forge_spectral'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                card.ability.extra.Remaining = 2
                return {
                    message = created_consumable and localize('k_plus_spectral') or nil
                }
            else
                card.ability.extra.Remaining = math.max(0, (card.ability.extra.Remaining) - 1)
            end
        end
        if context.forcetrigger then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Spectral', key = 'c_immolate', key_append = 'joker_forge_spectral'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
          end
    end
}
SMODS.Joker{ --Ezili
    key = "ezili",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Ezili',
        ['text'] = {
            [1] = '{C:purple}Balance{} {C:blue}Chips{} and {C:red}Mult{}',
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 6,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                balance = true,
            }
        end
        if context.forcetrigger then
            return {
                balance = true,
            }
        end
    end
}
SMODS.Joker{ --Pat Fusty
    key = "patfusty",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Pat Fusty',
        ['text'] = {
            [1] = '{C:attention}+100{} Card selection limit',
            [2] = '{C:inactive}big monke{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 7,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
    end,

    add_to_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(100)
        SMODS.change_discard_limit(100)
    end,

    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(-100)
        SMODS.change_discard_limit(-100)
    end
}
SMODS.Joker{ --Rosalia (v43)
    key = "rosalia",
    config = {
        extra = {
            chips = 43
        }
    },
    loc_txt = {
        ['name'] = 'Rosalia (v43)',
        ['text'] = {
            [1] = '{C:blue}+#1#{} Chips'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 3,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 2,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    chips = card.ability.extra.chips
                }
        end
    end
}
