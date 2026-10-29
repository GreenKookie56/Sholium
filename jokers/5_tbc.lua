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
    rarity = 1,
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
SMODS.Joker{ --Catasaurus
    key = "catasaurus",
    config = {
        extra = {
            Xmult = 2,
            odds = 8,
        }
    },
    loc_txt = {
        ['name'] = 'Catasaurus',
        ['text'] = {
            [1] = '{C:green}#1# in #2#{} chance to {X:red,C:white}X#3#{} Mult',
            [2] = 'rolls {C:attention}5{} times per hand'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 14
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sholium_catasaurus') 
        return {vars = {new_numerator, new_denominator, card.ability.extra.Xmult}}
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            for i = 1, 5 do -- bloonlatro goated mod go play it, i can't figure out how to code any of this lmao
                if SMODS.pseudorandom_probability(card, 'group_0_7cec881a', 1, card.ability.extra.odds, 'j_sholium_catasaurus', false) then
                    mult = mod_mult(mult * card.ability.extra.Xmult)
                    update_hand_text( { delay = 0 }, { mult = mult } )
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('multhit2')
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                        message = localize{
                            type = 'variable',
                            key = 'a_xmult',
                            vars = {card.ability.extra.Xmult},
                        }, 
                        colour = G.C.RED
                    })
                else
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot2', 1, 0.4)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_nope_ex')})
                end
            end
        end
        if context.forcetrigger then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end,
}
SMODS.Joker{ --Cyborg
    key = "cyborg",
    config = {
        extra = {
            Xmult = 1.3,
        }
    },
    loc_txt = {
        ['name'] = 'Cyborg Cat',
        ['text'] = {
            [1] = 'Each {C:attention}Enhanced Card{} in hand',
            [2] = 'gives {X:red,C:white}X#1#{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 14
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round  then
            if (function()
                local enhancements = SMODS.get_enhancements(context.other_card)
                for k, v in pairs(enhancements) do
                    if v then
                        return true
                    end
                end
                return false
            end)() then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
        if context.forcetrigger then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end,
}
SMODS.Joker {
    key = 'cancan',
    config = {
        extra = {
            Xmult = 3,
        }
    },
    loc_txt = {
        ['name'] = 'Can Can Cat',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{} Mult on the',
            [2] = 'first hand of the round',
            [3] = 'Give {C:money}$ {}equals the standard',
            [4] = '{C:attention}Blind reward{} and {C:attention}Hand reward{}',
            [5] = 'at the end of round'
        }
    },
    pos = {
        x = 0,
        y = 15
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
        if context.forcetrigger then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end,

    calc_dollar_bonus = function(self, card)
        if G.GAME.blind:get_type() == 'Small' then
            return lenient_bignum(3 + G.GAME.current_round.hands_left or 0)
        elseif G.GAME.blind:get_type() == 'Big' then
            return lenient_bignum(4 + G.GAME.current_round.hands_left or 0)
        else -- why isn't there a finisher blind type? 
            return lenient_bignum(5 + G.GAME.current_round.hands_left or 0)
        end
    end
}
SMODS.Joker{ --Gravolodon
    key = "gravolodon",
    config = {
        extra = {
            Xmult_mod = 0.5,
            Xmult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Gravolodon',
        ['text'] = {
            [1] = 'All played cards give extra',
            [2] = '{X:red,C:white}X#1#{} Mult per {C:attention}Stone Card{}',
            [3] = 'contained in hand when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 15
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

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult_mod}}
    end,

    calculate = function(self, card, context)
        if context.before then
            local mult = 1
            for k, v in ipairs(G.play.cards) do
                if SMODS.get_enhancements(v)["m_stone"] == true then
                    mult = mult + card.ability.extra.Xmult_mod
                end
            end
            if mult > 0 then
                card.ability.extra.Xmult = mult
            end
        end
        if context.individual and context.cardarea == G.play then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
        if context.forcetrigger then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end,
}
