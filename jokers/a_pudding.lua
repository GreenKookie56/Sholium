-- arrow format stolen from entropy
function FormatArrowMult(arrows, mult)
    mult = number_format(mult)
    if to_big(arrows) < to_big(-1) then 
        return "="..mult 
    elseif to_big(arrows) < to_big(0) then 
        return "+"..mult 
    elseif to_big(arrows) < to_big(6) then 
        if to_big(arrows) < to_big(1) then
            return "X"..mult
        end
        local arr = ""
        for i = 1, to_big(arrows):to_number() do
            arr = arr.."^"
        end
        return arr..mult
    else
        return "{"..arrows.."}"..mult
    end
end

if Sholium.config.pudding then
SMODS.Joker{ --mace
    key = "mace",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Mace',
        ['text'] = {
            [1] = 'This Joker gives {X:red,C:white}X0.6{} Mult',
            [2] = 'for each {C:attention}rank difference{} between',
            [3] = 'the {C:attention}highest{} and {C:attention}lowest{} scoring card',
            [4] = 'contained in played hand'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 10 -- WHHAT LMFAO
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
        if context.joker_main then
            local low, high = context.scoring_hand[1].base.nominal, context.scoring_hand[1].base.nominal
            for k, v in ipairs(context.scoring_hand) do
                if v.base.nominal < low then
                    low = v.base.nominal
                elseif v.base.nominal > high then
                    high = v.base.nominal
                end
            end
            if high - low > 0 then
                return {
                    Xmult = 0.6 * lenient_bignum((high - low) or 0)
                }
            else
                return {
                    Xmult = 0,
                    card_eval_status_text(card, "extra", nil, nil, nil, { message = "X0 Mult", colour = G.C.RED })
                }
            end
        end
    end

}

SMODS.Joker{ --Trident
    key = "trident",
    config = {
        extra = {
            levels0 = 3
        }
    },
    loc_txt = {
        ['name'] = 'Trident',
        ['text'] = {
            [1] = 'Increase level of',
            [2] = 'played {C:attention}poker hand{}',
            [3] = 'if played hand contains',
            [4] = '{C:attention}Three of a Kind{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 10
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
        if context.cardarea == G.jokers and context.before  then
            if next(context.poker_hands["Three of a Kind"]) then
                local target_hand = (context.scoring_name or "High Card")
                return {
                    level_up = true,
                    message = localize('k_level_up_ex')
                }
            end
        end
    end
}
SMODS.Joker{ --toolsmith
    key = "toolsmith",
    config = {
        extra = {
            mult_mod = 2,
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Toolsmith',
        ['text'] = {
            [1] = 'This Joker gains {C:red}+#1#{} Mult',
            [2] = 'when a card is bought from shop',
            [3] = '{C:inactive}(Currently{} {C:red}+#2#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 12
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mult_mod, card.ability.extra.mult}}
    end,
    
    calculate = function(self, card, context)
        if context.buying_card  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mult_mod
                    return true
                end,
                message = localize('k_upgrade_ex')
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.forcetrigger then
            card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mult_mod
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ --fletcher
    key = "fletcher",
    config = {
        extra = {
            req = 4,
            played = 0,
            money = 2,
            cardsinhand = 0
        }
    },
    loc_txt = {
        ['name'] = 'Fletcher',
        ['text'] = {
            [1] = 'Earns {C:gold}$#3#{}',
            [2] = 'every {C:attention}#1#{} card played {C:inactive}(#2#){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 11
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.req, card.ability.extra.played, card.ability.extra.money, (#(G.hand and G.hand.cards or {}) or 0)}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.played = (card.ability.extra.played) + #context.full_hand
                    return true
                end
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big(card.ability.extra.played) >= to_big(card.ability.extra.req) then
                local dollar = math.floor(card.ability.extra.played / card.ability.extra.req)
                return {
                    func = function()
                        ease_dollars(dollar * card.ability.extra.money)
                        card.ability.extra.played = card.ability.extra.played - (dollar * card.ability.extra.req)
                    return true
                    end,
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "$"..tostring(dollar * card.ability.extra.money), colour = G.C.MONEY})
                }
            end
        end
    end
}


SMODS.Joker{ --farmer
    key = "farmer",
    config = {
        extra = {
            discount_amount = '2'
        }
    },
    loc_txt = {
        ['name'] = 'Farmer',
        ['text'] = {
            [1] = 'Discount all consumables by {C:money}$2{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 11
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end
} 
      
local card_set_cost_ref = Card.set_cost
function Card:set_cost()
    card_set_cost_ref(self)
    
    if next(SMODS.find_card("j_sholium_farmer")) then
        if (self.ability.set == 'Tarot' or self.ability.set == 'Planet' or self.ability.set == 'Spectral') then
            self.cost = math.max(0, self.cost - (2))
        end
    end
    
    self.sell_cost = math.max(1, math.floor(self.cost / 2)) + (self.ability.extra_value or 0)
    self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
end


SMODS.Joker{ --cartographer
    key = "cartographer",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Cartographer',
        ['text'] = {
            [1] = '{C:attention}+2{} Shop Slots'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 12
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
    
    calculate = function(self, card, context)
        if context.forcetrigger then
            change_shop_size(2)
        end
    end,
    
    add_to_deck = function(self, card, from_debuff)
        change_shop_size(2)
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        change_shop_size(-2)
    end
}

SMODS.Joker{ --armorsmith
    key = "armorsmith",
    config = {
        extra = {
            bought = 0,
            xmult_mod = 0.25,
            xmult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Armorsmith',
        ['text'] = {
            [1] = 'This Joker gains {X:red,C:white}X#2#{} Mult',
            [2] = 'for every {C:attention}4{} cards {C:inactive}(#1#){} bought in shop',
            [3] = '{C:inactive}(Currently {}{X:red,C:white}X#3#{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 11
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.bought, card.ability.extra.xmult_mod, card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.buying_card  and not context.blueprint then
            if to_big(card.ability.extra.bought) < to_big(3) then
                return {
                    func = function()
                        card.ability.extra.bought = (card.ability.extra.bought) + 1
                        return true
                    end
                }
            else
                return {
                    func = function()
                        card.ability.extra.bought = 0
                        return true
                    end,
                    extra = {
                        func = function()
                            card.ability.extra.xmult = (card.ability.extra.xmult) + card.ability.extra.xmult_mod
                            return true
                        end,
                        message = localize('k_upgrade_ex')
                    }
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
        if context.forcetrigger then
            card.ability.extra.xmult = (card.ability.extra.xmult) + card.ability.extra.xmult_mod
            return {
                Xmult = card.ability.extra.xmult
            }
        end
    end
}
SMODS.Joker{ --librarian
    key = "librarian",
    config = {
        extra = {
            odds = 3
        }
    },
    loc_txt = {
        ['name'] = 'Librarian',
        ['text'] = {
            [1] = 'When shop is rerolled,',
            [2] = '{C:green}#1# in #2#{} chance to create',
            [3] = 'a random {C:spectral}spectral{} card'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 12
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sholium_librarian') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.reroll_shop  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_7cec881a', 1, card.ability.extra.odds, 'j_sholium_librarian', false) then
                    SMODS.calculate_effect({func = function()
                        
                        for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                func = function()
                                    play_sound('timpani')
                                    SMODS.add_card({ set = 'Spectral', soulable = true, })                            
                                    card:juice_up(0.3, 0.5)
                                    return true
                                end
                            }))
                        end
                        delay(0.6)
                        
                        if created_consumable then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                        end
                        return true
                    end}, card)
                end
            end
        end
        if context.forcetrigger then
                for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            play_sound('timpani')
                            SMODS.add_card({ set = 'Spectral', soulable = true, })                            
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                end
                delay(0.6)
                        
                if created_consumable then
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                end
                return true
        end
    end
}
SMODS.Joker{ --cleric
    key = "cleric",
    config = {
        extra = {
            xmult = 1,
            xmult_mod = 0.32
        }
    },
    loc_txt = {
        ['name'] = 'Cleric',
        ['text'] = {
            [1] = 'This Joker gains {X:red,C:white}X#2#{} Mult',
            [2] = 'per scoring {C:attention}Mult Card{} played,',
            [3] = 'removes {C:attention}Mult Enhancement{} afterwards',
            [4] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 12
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
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult, card.ability.extra.xmult_mod}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if SMODS.get_enhancements(context.other_card)["m_mult"] == true then
                local scored_card = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        
                        scored_card:set_ability(G.P_CENTERS.c_base)
                        return true
                    end
                }))
                card.ability.extra.xmult = (card.ability.extra.xmult) + card.ability.extra.xmult_mod
            end
        end
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
    end
}


SMODS.Joker{ --nitwit
    key = "nitwit",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Nitwit',
        ['text'] = {
            [1] = 'insert text here'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 12
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 10,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  and not context.blueprint then
            local created_joker = false
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                created_joker = true
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_nitwit' })
                        if joker_card then
                            
                            
                        end
                        G.GAME.joker_buffer = 0
                        return true
                    end
                }))
            end
            return {
                message = created_joker and localize('k_plus_joker') or nil
            }
        end
    end
}

-- hostile mobs

SMODS.Joker{ --zombie
    key = "zombie",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Zombie',
        ['text'] = {
            [1] = 'When this card is sold,',
            [2] = 'create 2 {C:attention}Empress{}{C:tarot} Tarots{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 10
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.selling_self or context.forcetrigger then
            return {
                func = function()
                    
                    for i = 1, math.min(2, G.consumeables.config.card_limit - #G.consumeables.cards) do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                play_sound('timpani')
                                SMODS.add_card({ set = 'Tarot', key = 'c_empress'})                            
                                card:juice_up(0.3, 0.5)
                                return true
                            end
                        }))
                    end
                    delay(0.6)
                    
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                    end
                    return true
                end
            }
        end
    end
}

SMODS.Joker{ --creeper
    key = "creeper",
    config = {
        extra = {
            xmult = 3
        }
    },
    loc_txt = {
        ['name'] = 'Creeper',
        ['text'] = {
            [1] = 'On last hand of the round,',
            [2] = '{X:red,C:white}X#1#{} Mult and destory all scoring cards',
            [3] = 'and {C:red}self destucts{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 10
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if (context.cardarea == G.jokers and context.joker_main and to_big(G.GAME.current_round.hands_left) <= to_big(0)) or context.forcetrigger then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
        if context.after and context.cardarea == G.jokers  and not context.blueprint then
            if to_big(G.GAME.current_round.hands_left) <= to_big(0) then
                return {
                    func = function()
                        local target_joker = card
                        
                        if target_joker then
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:explode({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                        end
                        return true
                    end
                }
            end
        end
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if to_big(G.GAME.current_round.hands_left) <= to_big(0) then
                context.other_card.should_destroy = true
            end
        end
    end
}
SMODS.Joker{ --skeleton
    key = "skeleton",
    config = {
        extra = {
            mult = 10,
            scored = 0
        }
    },
    loc_txt = {
        ['name'] = 'Skeleton',
        ['text'] = {
            [1] = '{C:red}+#1#{} Mult every 3 cards scored',
            [2] = '{C:inactive}(#2#/3){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 10
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
        
        return {vars = {card.ability.extra.mult, card.ability.extra.scored}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if to_big((card.ability.extra.scored or 0)) < to_big(2) then
                card.ability.extra.scored = (card.ability.extra.scored) + 1
            else
                card.ability.extra.scored = 0
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
        if context.forcetrigger then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker{ --babyzombie
    key = "babyzombie",
    config = {
        extra = {
            odds = 2,
        }
    },
    loc_txt = {
        ['name'] = 'Baby Zombie',
        ['text'] = {
            [1] = 'Each scoring card has',
            [2] = '{C:green}#1# in #2#{} chance to retrigger'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 10
    },
    display_size = {
        w = 71 * 0.6, 
        h = 95 * 0.6
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sholium_babyzombie') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, 'group_0_51a47a35', 1, card.ability.extra.odds, 'j_sholium_babyzombie', false) then
                return {
                    repetitions = 1,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}
SMODS.Joker{ --spider
    key = "spider",
    config = {
        extra = {
            pb_bonus = 16,
            perma_bouns = 0
        }
    },
    loc_txt = {
        ['name'] = 'Spider',
        ['text'] = {
            [1] = 'Each played {C:attention}8{} permanently',
            [2] = 'gains {C:blue}+#1#{} Chips when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 10
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.pb_bonus}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 8 then
                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.pb_bonus
                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.CHIPS }, card = card
                }
            end
        end
    end
}
SMODS.Joker{ --witch
    key = "witch",
    config = {
        extra = {
            played = 0,
            req = 3
        }
    },
    loc_txt = {
        ['name'] = 'Witch',
        ['text'] = {
            [1] = 'Create a random {C:tarot}Tarot{}',
            [2] = 'for every {C:attention}#2#{} hands played {C:inactive}(#1#){}',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 10
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
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.played, card.ability.extra.req}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            if to_big(card.ability.extra.played) < to_big(card.ability.extra.req - 1) then
                if not context.blueprint then
                    card.ability.extra.played = (card.ability.extra.played) + 1
                end
            elseif to_big(card.ability.extra.played) >= to_big(card.ability.extra.req - 1) then
                card.ability.extra.played = (card.ability.extra.played) + 1
                for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            play_sound('timpani')
                            SMODS.add_card({ set = 'Tarot', })                            
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                end
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                delay(0.6)
            end
        end
        if context.after and context.cardarea == G.jokers  and not context.blueprint then
            if to_big(card.ability.extra.played) >= to_big(card.ability.extra.req) then
                return {
                    func = function()
                        card.ability.extra.played = 0
                        return true
                    end
                }
            end
        end
    end
}

SMODS.Joker{ --enderman
    key = "enderman",
    config = {
        extra = {
            xmult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Enderman',
        ['text'] = {
            [1] = 'Convert each remaining discards',
            [2] = 'into {X:red,C:white}X1{} Mult on first hand of the round,',
            [3] = '{C:attention}Resets{} at end of round',
            [4] = '{C:inactive}(Currently {}{X:red,C:white}X#1#{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 10
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    func = function()
                        card.ability.extra.xmult = 1 + (G.GAME.current_round.discards_left or 0)
                        return true
                    end,
                    extra = {
                        
                        func = function()
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = tostring(card.ability.extra.xmult), colour = G.C.BLUE})
                            G.GAME.current_round.discards_left = 0
                            return true
                        end,
                        colour = G.C.GREEN
                    }
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.xmult = 1
                    return true
                end
            }
        end
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker{ --guardian
    key = "guardian",
    config = {
        extra = {
            mult = 9
        }
    },
    loc_txt = {
        ['name'] = 'Guardian',
        ['text'] = {
            [1] = 'Each played {C:attention}3, 6, 9{}',
            [2] = 'gives {C:red}+#1#{} Mult when scored'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 11
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

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mult}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (context.other_card:get_id() == 3 or context.other_card:get_id() == 6 or context.other_card:get_id() == 9) then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
        if context.forcetrigger then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker{ --elderguardian
    key = "elderguardian",
    config = {
        extra = {
            money = 8
        }
    },
    loc_txt = {
        ['name'] = 'Elder Guardian',
        ['text'] = {
            [1] = 'Each played {C:attention}3, 6, 9{}',
            [2] = 'gives {C:money}+$#1#{} when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 11
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
        
        return {vars = {card.ability.extra.money}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if (context.other_card:get_id() == 3) or (context.other_card:get_id() == 6) or (context.other_card:get_id() == 9) then
                return {
                    
                    func = function()
                        
                        local current_dollars = G.GAME.dollars
                        local target_dollars = G.GAME.dollars + card.ability.extra.money
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                        card_eval_status_text(context.other_card or card, 'extra', nil, nil, nil, {message = "$"..tostring(card.ability.extra.money), colour = G.C.MONEY})
                        return true
                    end
                }
            end
        end
        if context.forcetrigger then
            return {
                dollars = card.ability.extra.money
            }
        end
    end
}
SMODS.Joker{ --Piglin
    key = "piglin",
    config = {
        extra = {
            tarot = 0
        }
    },
    loc_txt = {
        ['name'] = 'Piglin',
        ['text'] = {
            [1] = 'Grant a {C:tarot}Tarot{} if played hand',
            [2] = 'contains a scoring {C:attention}Gold Card{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    enhancement_gate = 'm_gold',
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.tarot}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if (SMODS.get_enhancements(context.other_card)["m_gold"] == true and to_big((card.ability.extra.tarot or 0)) < to_big(1)) then
                card.ability.extra.tarot = 1
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big(card.ability.extra.tarot) > to_big(0) then
                for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            play_sound('timpani')
                            SMODS.add_card({ set = 'Tarot', })                            
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                end
                delay(0.6)
                return {
                    message = created_consumable and localize('k_plus_tarot') or nil
                }
            end
        end
        if context.after and context.cardarea == G.jokers  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.tarot = 0
                    return true
                end
            }
        end
        if context.forcetrigger then
            for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('timpani')
                        SMODS.add_card({ set = 'Tarot', })                            
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
        end
    end
}
SMODS.Joker{ --zombiepigman
    key = "zombiepigman",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Zombified Piglin',
        ['text'] = {
            [1] = 'When this card is sold,',
            [2] = 'create a {C:attention}Devil{} and an {C:attention}Empress{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 11
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.selling_self  and not context.blueprint or context.forcetrigger then
            return {
                func = function()
                    
                    for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                play_sound('timpani')
                                SMODS.add_card({ set = 'Tarot', key = 'c_devil'})                            
                                card:juice_up(0.3, 0.5)
                                return true
                            end
                        }))
                    end
                    delay(0.6)
                    return true
                end,
                extra = {
                    func = function()
                        
                        for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                func = function()
                                    play_sound('timpani')
                                    SMODS.add_card({ set = 'Tarot', key = 'c_empress'})                            
                                    card:juice_up(0.3, 0.5)
                                    return true
                                end
                            }))
                        end
                        delay(0.6)
                        return true
                    end,
                    colour = G.C.PURPLE
                }
            }
        end
    end
}
SMODS.Joker{ --hoglin
    key = "hoglin",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Hoglin',
        ['text'] = {
            [1] = 'If played hand is {C:attention}exactly 1{} card,',
            [2] = 'increase rank of this card by {C:attention}2{}',
            [3] = 'each time it is scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 11
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if to_big(#context.full_hand) == to_big(1) then
            local scored_card = context.other_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    assert(SMODS.modify_rank(scored_card, 2))
                    return true
                end
            }))
            end
        end
    end
}
SMODS.Joker{ --Piglin Brute
    key = "piglinbrute",
    config = {
        extra = {
            mult = 1,
            scale = 2
        }
    },
    loc_txt = {
        ['name'] = 'Piglin Brute',
        ['text'] = {
            [1] = 'This Joker gains {X:red,C:white}X#2#{} Mult',
            [2] = 'if played hand contains',
            [3] = 'a {C:attention}Straight Flush{}',
            [4] = '{C:inactive}(Currently {}{X:red,C:white}X#1#{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 7
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mult, card.ability.extra.scale}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if next(context.poker_hands["Straight Flush"]) then
                return {
                    func = function()
                        card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.scale
                        return true
                    end,
                    message = localize('k_upgrade_ex')
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
            return {
                Xmult = card.ability.extra.mult
            }
        end
        if context.forcetrigger then
            return {
                func = function()
                    card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.scale
                    Xmult = card.ability.extra.mult
                    return true
                end
            }
        end
    end
}
SMODS.Joker{ --witherskeleton
    key = "witherskeleton",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Wither Skeleton',
        ['text'] = {
            [1] = 'Convert each played and',
            [2] = 'scoring cards into {C:spades}Spades{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 11
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if context.other_card and not context.other_card:is_suit("Spades") then
                local scored_card = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        
                        assert(SMODS.change_base(scored_card, "Spades", nil))
                        card_eval_status_text(scored_card, 'extra', nil, nil, nil, {message = "Withered!", colour = G.C.ORANGE})
                        return true
                    end
                }))
            end
        end
    end
}
SMODS.Joker{ --blaze
    key = "blaze",
    config = {
        extra = {
            odds = 2
        }
    },
    loc_txt = {
        ['name'] = 'Blaze',
        ['text'] = {
            [1] = 'if played hand contains a {C:attention}Three of a Kind{},',
            [2] = '{C:green}#1# in #2#{} chance to create an {C:attention}Immolate{}' -- oops! all 3oak synergies
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5, 
        y = 11
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
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sholium_blaze') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if next(context.poker_hands["Three of a Kind"]) then
                if SMODS.pseudorandom_probability(card, 'group_0_22491ffe', 1, card.ability.extra.odds, 'j_sholium_blaze', false) then
                    for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                play_sound('timpani')
                                SMODS.add_card({ set = 'Spectral', key = 'c_immolate'})                            
                                card:juice_up(0.3, 0.5)
                                return true
                            end
                        }))
                    end
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = created_consumable and localize('k_plus_spectral') or nil, colour = G.C.SECONDARY_SET.Spectral})
                end
            end
        end
    end
}
SMODS.Joker{ --shulker
    key = "shulker",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Shulker',
        ['text'] = {
            [1] = 'At the end of shop,',
            [2] = 'turns all held consumables',
            [3] = 'into {C:dark_edition}Negative{} Edition'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 11
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
        if context.ending_shop  and not context.blueprint then
			for i, v in pairs(G.consumeables.cards) do
				if not v.edition or not v.edition.negative then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card = v
                        card:set_edition("e_negative", true)
                        card:add_to_deck()
                        return true
                    end
                }))
				end
			end
        end
    end
}

-- misc

SMODS.Joker{ --Cobblestone Generator
    key = "cobble",
    config = {
        extra = {
            chipsmod = 8,
            chips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Cobblestone Generator',
        ['text'] = {
            [1] = 'This Joker gains {C:blue}+#1#{} Chips',
            [2] = 'if played hand contains a',
            [3] = '{C:diamonds}Light suited{} and a {C:clubs}dark suited{} card,',
            [4] = '{C:inactive}(Currently {}{C:blue}+#2#{}{C:inactive} Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 10
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chipsmod, card.ability.extra.chips}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if ((function()
                local count = 0
                for _, playing_card in pairs(context.scoring_hand or {}) do
                    if playing_card:is_suit("Spades") or playing_card:is_suit("Clubs") then
                        count = count + 1
                    end
                end
                return count >= 1
            end)() and (function()
                local count = 0
                for _, playing_card in pairs(context.scoring_hand or {}) do
                    if playing_card:is_suit("Hearts") or playing_card:is_suit("Diamonds") then
                        count = count + 1
                    end
                end
                return count >= 1
            end)()) then
                return {
                    func = function()
                        card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.chipsmod
                        return true
                    end,
                message = localize('k_upgrade_ex')
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.forcetrigger then
            card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.chipsmod
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}


SMODS.Joker{ --Low Tier 1
    key = "lowtier1",
    config = {
        extra = {
            repetitions0 = 2
        }
    },
    loc_txt = {
        ['name'] = 'Low Tier 1',
        ['text'] = {
            [1] = 'Retrigger each played {C:attention}Ace{} twice'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 13
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
            if context.other_card:get_id() == 14 then
                return {
                    repetitions = 2,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}

SMODS.Joker{ --High Tier 1
    key = "hightier1",
    config = {
        extra = {
            chips0 = 50,
            mult0 = 10,
            xmult0 = 1.5
        }
    },
    loc_txt = {
        ['name'] = 'High Tier 1',
        ['text'] = {
            [1] = 'Each played {C:attention}Ace{} counts as having',
            [2] = 'all non {C:dark_edition}Negative{} vanilla editions'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 13
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 14 then
                return {
                    chips = 50,
                    extra = {
                        mult = 10,
                        extra = {
                            Xmult = 1.5
                        }
                    }
                }
            end
        end
    end
}

SMODS.Joker{ --Solo
    key = "solo",
    config = {
        extra = {
            mult_mod = 1,
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Solo',
        ['text'] = {
            [1] = 'Adds the amount of times {C:attention}High Card{}',
            [2] = 'has been played this game to {C:red}Mult{}',
            [3] = '{C:inactive}(Currently {}{C:red}+#1#{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 12
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    demicoloncomapt = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {(G.GAME.hands['High Card'].played or 0)}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if context.scoring_name == "High Card" then
                return {
                    message = localize('k_upgrade_ex')
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                mult = G.GAME.hands['High Card'].played
            }
        end
    end
}

SMODS.Joker{ --Party
    key = "party",
    config = {
        extra = {
            chips = 0,
            jokercount = 0
        }
    },
    loc_txt = {
        ['name'] = 'Party',
        ['text'] = {
            [1] = 'If the total amount of played and scoring cards',
            [2] = '{C:attention}exceeds{} that of owned Jokers,',
            [3] = 'This Joker gains {C:blue}3x{} the amount of',
            [4] = 'owned Jokers to {C:blue}Chips{}',
            [5] = '{C:inactive}(Currently {}{C:blue}+#1#{}{C:inactive} Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 12
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chips, #(G.jokers and (G.jokers and G.jokers.cards or {}) or {})}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if to_big(#context.scoring_hand) > to_big(#(G.jokers and G.jokers.cards or {})) then
                return {
                    func = function()
                        card.ability.extra.chips = (card.ability.extra.chips) + (#(G.jokers and G.jokers.cards or {})) * 3
                        return true
                    end,
                    message = localize('k_upgrade_ex')
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.forcetrigger then
            card.ability.extra.chips = (card.ability.extra.chips) + (#(G.jokers and G.jokers.cards or {})) * 3
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
-- arrow format stolen from entropy
function FormatArrowMult(arrows, mult)
    mult = number_format(mult)
    if to_big(arrows) < to_big(-1) then 
        return "="..mult 
    elseif to_big(arrows) < to_big(0) then 
        return "+"..mult 
    elseif to_big(arrows) < to_big(6) then 
        if to_big(arrows) < to_big(1) then
            return "X"..mult
        end
        local arr = ""
        for i = 1, to_big(arrows):to_number() do
            arr = arr.."^"
        end
        return arr..mult
    else
        return "{"..arrows.."}"..mult
    end
end

SMODS.Joker{ --Samurai
    key = "samurai",
    config = {
        extra = {
            xmult = 7,
            scored = 0
        }
    },
    loc_txt = {
        ['name'] = 'Samurai',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{} Mult every {C:attention}7th{} scored card',
            [2] = '{C:inactive}(Currently #2#/7){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6, y = 9 -- Nice
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult, card.ability.extra.scored}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if to_big((card.ability.extra.scored or 0)) < to_big(6) then
                card.ability.extra.scored = (card.ability.extra.scored) + 1
                return {
                    message = "domp"
                }
            else
                card.ability.extra.scored = 0
                return {
                    Xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

if Cryptid then
SMODS.Joker{ --Mabel
    key = "mabel",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Mabel',
        ['text'] = {
            [1] = 'When a hand is played,',
            [2] = '{C:attention}Randomize{} value of all Jokers',
            [3] = 'by {C:attention}X0.8{} to {C:attention}X1.3{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 9
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if (context.cardarea == G.jokers and context.before) or context.forcetrigger then
            local result = pseudorandom(pseudoseed("sholium_mabel"), 80, 130)
            local check = false
            for i = 1, #G.jokers.cards do
                if not (G.jokers.cards[i] == card) then
                    if not Card.no(G.jokers.cards[i], "immutable", true) then
                        check = true
						Cryptid.manipulate(G.jokers.cards[i], { value = result / 100 })
                    end
                end
            end
            if check then
                card_eval_status_text(card, "extra", nil, nil, nil, { message = "X"..tostring(result / 100), colour = G.C.GREEN })
            end
        end
    end
}
end
SMODS.Joker{ --Loaf
    key = "loaf",
    config = {
        extra = {
            chips_mod = 5,
            chips = 0,
        }
    },
    loc_txt = {
        ['name'] = 'Loaf',
        ['text'] = {
            [1] = 'This Joker gains {C:blue}+#1#{} Chips for',
            [2] = 'each unused {C:blue}Hands{} and {C:red}Discards{}',
            [3] = 'at the end of round',
            [4] = '{C:inactive}(Currently {}{C:blue}+#2#{}{C:inactive} Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 9
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chips_mod, card.ability.extra.chips}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            local chips_value = card.ability.extra.chips
            return {
                func = function()
                    card.ability.extra.chips = (card.ability.extra.chips) + ((G.GAME.current_round.hands_left or 0) + (G.GAME.current_round.discards_left or 0)) * card.ability.extra.chips_mod
                    return true
                end,
                message = localize('k_upgrade_ex')
            }
        end
        if context.forcetrigger then
            card.ability.extra.chips = (card.ability.extra.chips) + ((G.GAME.current_round.hands_left or 0) + (G.GAME.current_round.discards_left or 0)) * card.ability.extra.chips_mod
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

SMODS.Joker{ --Tom
    key = "tom",
    config = {
        extra = {
            mult_mod = 1.6,
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Tom',
        ['text'] = {
            [1] = 'This Joker gains {C:red}+#1#{} Mult',
            [2] = 'when each played {C:attention}4{} is scored',
            [3] = '{C:inactive}(Currently {}{C:red}+#2#{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 9
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mult_mod, card.ability.extra.mult}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if context.other_card:get_id() == 4 then
                return {
                    func = function()
                    card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mult_mod
                        return true
                    end,
                    message = localize('k_upgrade_ex')
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.forcetrigger then
            card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mult_mod
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ --Ellen
    key = "ellen",
    config = {
        extra = {
            xmult = 3
        }
    },
    loc_txt = {
        ['name'] = 'Ellen',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{} Mult if played',
            [2] = '{C:attention}poker hand{} hasn\'t been',
            [3] = 'played this round before'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 9
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
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if not (G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1) then
                return {
                    Xmult = card.ability.extra.xmult
                }
            end
        end
        if context.forcetrigger then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
    end
}
	
SMODS.Joker{ --King George
    key = "kinggeorge",
    config = {
        extra = {
            eor = 3,
            eor_mod = 0.3
        }
    },
    loc_txt = {
        ['name'] = 'King George',
        ['text'] = {
            [1] = 'Earn {C:gold}$#1#{} at end of round',
            [2] = 'increases by {C:gold}+$#2#{} when each',
            [3] = 'played {C:diamonds}Diamonds{} is scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 9
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {lenient_bignum(card.ability.extra.eor), lenient_bignum(card.ability.extra.eor_mod)}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if context.other_card:is_suit("Diamonds") then
                return {
                    func = function()
                    card.ability.extra.eor = lenient_bignum(card.ability.extra.eor) + lenient_bignum(card.ability.extra.eor_mod)
                    return true
                end,
                    message = localize('k_upgrade_ex'),
                    extra = {
                        colour = G.C.MONEY
                    }
                }
            end
        end
        if context.forcetrigger then
            card.ability.extra.eor = lenient_bignum(card.ability.extra.eor) + lenient_bignum(card.ability.extra.eor_mod)
                return {
                    dollars = lenient_bignum(card.ability.extra.eor),
                }
        end
    end,

    calc_dollar_bonus = function(self, card)
        if to_big(card.ability.extra.eor) > to_big(0) then
            return lenient_bignum(card.ability.extra.eor)
        end
    end
}
SMODS.Joker{ --Kings Council
    key = "kingscouncil",
    config = {
        extra = {
            xmult = 1,
            xmult_mod = 0.3
        }
    },
    loc_txt = {
        ['name'] = 'Kings Council',
        ['text'] = {
            [1] = 'When a hand is played',
            [2] = 'with {C:attention}more than 2{} scoring cards,',
            [3] = 'this Joker gains {X:red,C:white}X#2#{} Mult,',
            [4] = 'otherwise set {X:red,C:white}XMult{} to {C:red}0{}',
            [5] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 13
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    demicolon_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult, card.ability.extra.xmult_mod}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if to_big(#context.scoring_hand) <= to_big(2) then
                return {
                    func = function()
                        card.ability.extra.xmult = 0
                        return true
                    end,
                    message = localize('k_reset')
                }
            elseif to_big(#context.scoring_hand) > to_big(2) then
                return {
                    func = function()
                        card.ability.extra.xmult = (card.ability.extra.xmult) + card.ability.extra.xmult_mod
                        return true
                    end,
                    message = localize('k_upgrade_ex')
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if card.ability.extra.xmult > 0 then
                return {
                Xmult = card.ability.extra.xmult
                }
            else
                return {
                    Xmult = 0,
                    card_eval_status_text(card, "extra", nil, nil, nil, { message = "X0 Mult", colour = G.C.RED })
                }
            end
        end
        if context.forcetrigger then
            card.ability.extra.xmult = (card.ability.extra.xmult) + card.ability.extra.xmult_mod
            if card.ability.extra.xmult > 0 then
                return {
                Xmult = card.ability.extra.xmult
                }
            else
                return {
                    Xmult = 0,
                    card_eval_status_text(card, "extra", nil, nil, nil, { message = "X0 Mult", colour = G.C.RED })
                }
            end
        end
    end
}
SMODS.Joker{ --Soundwave controller
    key = "soundwavecontroller",
    config = {
        extra = {
            handsremaining = 0
        }
    },
    loc_txt = {
        ['name'] = 'Soundwave controller',
        ['text'] = {
            [1] = '{C:red}+20X-5X^2{} Mult,',
            [2] = 'where {C:red}X{} is the value of',
            [3] = 'remaining hands'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 13
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {(G.GAME.current_round.hands_left or 0)}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = (20 * G.GAME.current_round.hands_left - 5 * (G.GAME.current_round.hands_left ^ 2))
            }
        end
    end
}


SMODS.Joker{ --The Tree is Loud
    key = "thetreeisloud",
    config = {
        extra = {
            increase = 3
        }
    },
    loc_txt = {
        ['name'] = 'The Tree is Loud',
        ['text'] = {
            [1] = 'This Joker gains {C:money}$#1#{} of {C:attention}sell value{}',
            [2] = 'when each played {C:attention}3{} is scored',
            [3] = '{C:inactive}The Three\'s endowed?{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 13
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.increase}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if context.other_card:get_id() == 3 then
                local my_pos = nil
                local check = false
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then
                        check = true
                        my_pos = i
                        break
                    end
                end
                local target_card = G.jokers.cards[my_pos]
                target_card.ability.extra_value = (card.ability.extra_value or 0) + card.ability.extra.increase
                target_card:set_cost()
			if check then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize('k_upgrade_ex'), colour = G.C.GREEN }
				)
			end
            end
        end
        if context.forcetrigger then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            local target_card = G.jokers.cards[my_pos]
            target_card.ability.extra_value = (card.ability.extra_value or 0) + card.ability.extra.increase
            target_card:set_cost()
        end
    end
}

if Cryptid then
SMODS.Joker{ --Ninja Kiwi balance be like
    key = "nksucks",
    config = {
        extra = {
            version = 53
        }
    },
    loc_txt = {
        ['name'] = 'Ninja Kiwi balance be like',
        ['text'] = {
            [1] = 'At the end of round,',
            [2] = '{C:attention}Increase{} value of Joker to the {C:attention}right{} by {C:attention}50%{},',
            [3] = '{C:attention}Decrease{} value of Joker to the {C:attention}left{} by {C:attention}50%{}',
            [4] = 'if both Jokers have mutable values'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 9
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.version}}
    end,
    
	calculate = function(self, card, context)
		if
			(context.end_of_round and not context.repetition and not context.individual and not context.blueprint)
			or context.forcetrigger
		then
			local check = false
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i < #G.jokers.cards and i >1 then
						if not (Card.no(G.jokers.cards[i + 1], "immutable", true) or Card.no(G.jokers.cards[i - 1], "immutable", true)) then
							check = true
							Cryptid.manipulate(G.jokers.cards[i + 1], { value = 1.5 })
							Cryptid.manipulate(G.jokers.cards[i - 1], { value = 0.5 })
						end
					end
				end
			end
			if check then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = 'update is out!', colour = G.C.GREEN }
				)
			end
		end
	end
}
end
SMODS.Joker{ --Ten the purples
    key = "tenthepurples",
    config = {
    },
    loc_txt = {
        ['name'] = 'Ten the purples',
        ['text'] = {
            [1] = 'When {C:attention}Boss Blind{} is selected,',
            [2] = '{C:attention}disable{} Blind effect and {C:red}X2{} Blind size',
            [3] = '{C:inactive,s:0.7}haha every boss blinds are the wall now{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 9
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.setting_blind  and not context.blueprint then
            if G.GAME.blind.boss then
                return {
                    func = function()
                        if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.GAME.blind:disable()
                                    play_sound('timpani')
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled'), colour = G.C.GREEN})
                        end
                        return true
                    end,
                    extra = {
                        
                        func = function()
                            if G.GAME.blind.in_blind then
                                G.GAME.blind.chips = G.GAME.blind.chips * 2
                                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                                G.HUD_blind:recalculate()
                                return true
                            end
                        end,
                        colour = G.C.GREEN
                    }
                }
            end
        end
    end
}

-- peak content

SMODS.Joker{ --Bing Bong
    key = "bingbong",
    config = {
        extra = {
            remain = 5,
            joker_slots0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Bing Bong',
        ['text'] = {
            [1] = '{C:green}i am bing bong{} {C:inactive}(#1#){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 9
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.remain}}
    end,
    
    calculate = function(self, card, context)
        if context.ante_change  and not context.blueprint then
            if to_big(card.ability.extra.remain) > to_big(1) then
                return {
                    func = function()
                        card.ability.extra.remain = math.max(0, (card.ability.extra.remain) - 1)
                        return true
                    end
                }
            elseif to_big(card.ability.extra.remain) <= to_big(1) then
                return {
                    func = function()
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "You Peaked!", colour = G.C.DARK_EDITION})
                        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                        return true
                    end,
                    extra = {
                        func = function()
                            card.ability.extra.remain = 5
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            end
        end
    end
}

SMODS.Joker{ --coconut
    key = "coconut",
    config = {
        extra = {
            hand_size_increase = '1',
            chips = 125
        }
    },
    loc_txt = {
        ['name'] = 'Coconut',
        ['text'] = {
            [1] = '{C:blue}+#1#{} Chips',
            [2] = '{C:attention}-1{} Hand Size'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 12
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
        
        return {vars = {card.ability.extra.chips}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra.chips
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

SMODS.Joker{ --lolipop
    key = "lolipop",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Lolipop',
        ['text'] = {
            [1] = 'When this card is sold,',
            [2] = 'apply {C:dark_edition}Polychrome{} and {C:dark_edition}Perishable{}',
            [3] = 'to adjacent Jokers'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 12
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'jud' and args.source ~= 'rif' 
            or args.source == 'sho' or args.source == 'buf' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
    end,
    calculate = function(self, card, context)
		if
			(context.selling_self and not context.retrigger_joker and not context.blueprint_card)
		then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i > 1 then
						G.jokers.cards[i - 1]:set_edition({ polychrome = true })
						G.jokers.cards[i - 1]:set_perishable()
					end
					if i < #G.jokers.cards then
						G.jokers.cards[i + 1]:set_edition({ polychrome = true })
						G.jokers.cards[i + 1]:set_perishable()
					end
				end
			end
		end
    end
}
SMODS.Joker{ --Sports drink
    key = "sportsdrink",
    config = {
        extra = {
            xchips = 3.5,
            xchipsmod = 0.1
        }
    },
    loc_txt = {
        ['name'] = 'Sports drink',
        ['text'] = {
            [1] = 'If remaining hands is less than {C:blue}2{},',
            [2] = '{X:blue,C:white}X#1#{} Chips and {X:blue,C:white}-X#2#{} afterwards',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 13 -- holy moly
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xchips, card.ability.extra.xchipsmod}}
    end,
    
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                x_chips = card.ability.extra.xchips
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big(G.GAME.current_round.hands_left) < to_big(2) then
                return {
                    x_chips = card.ability.extra.xchips
                }
            end
        end
        if context.after and context.cardarea == G.jokers  and not context.blueprint then
            if to_big(G.GAME.current_round.hands_left) < to_big(2) then
                if to_big(card.ability.extra.xchips) > to_big(card.ability.extra.xchipsmod) then
                    return {
                        func = function()
                            card.ability.extra.xchips = math.max(0, (card.ability.extra.xchips) - card.ability.extra.xchipsmod)
                            return true
                        end,
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(card.ability.extra.xchipsmod), colour = G.C.BLUE})
                    }
                else
                    return {
                        func = function()
                            local target_joker = card
                        
                        if target_joker then
                            if target_joker.ability.eternal then
                                target_joker.ability.eternal = nil
                            end
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Eaten!", colour = G.C.RED})
                        end
                        return true
                    end
                    }
                end
            end
        end
    end
}
SMODS.Joker{ -- Fortified Milk
    key = "fortmilk",
    config = {
        extra = {
            active = 0,
            scale0 = 1,
            rotation0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Fortified Milk',
        ['text'] = {
            [1] = 'At the end of round,',
            [2] = 'if scored chips is less than required,',
            [3] = '{C:attention}prevents death{} until the end of this ante',
            [4] = 'and {C:red}self-destructs{} afterwards'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 12
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.active}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval  and not context.blueprint then
            local target_card = context.other_card
            local function juice_card_until_(card, eval_func, first, delay) -- balatro function doesn't allow for custom scale and rotation
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',delay = delay or 0.1, blocking = false, blockable = false, timer = 'REAL',
                func = (function() if eval_func(card) then if not first or first then card:juice_up(1, 1) end;juice_card_until_(card, eval_func, nil, 0.8) end return true end)
                }))
            end
            return {
                saved = true,
                message = 'milk',
                extra = {
                    func = function()
                    local eval = function() return not G.RESET_JIGGLES end
                        juice_card_until_(card, eval, true)
                        return true
                    end,
                    colour = G.C.WHITE,
                    extra = {
                        func = function()
                            card.ability.extra.active = 1
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            }
        end
        if context.ante_change  and not context.blueprint then
            if to_big(card.ability.extra.active) ~= to_big(0) then
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
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "喝完了!", colour = G.C.RED})
                        end
                        return true
                    end
                }
            end
        end
    end
}
SMODS.Joker{ --Ancient idol
    key = "ancientidol",
    config = {
        extra = {
            slot_change = '1',
            xmult = 3
        }
    },
    loc_txt = {
        ['name'] = 'Ancient idol',
        ['text'] = {
            [1] = '{C:red}-1{} consumable slot',
            [2] = 'Each {C:attention}#2#{} held in hand',
            [3] = 'give {X:red,C:white}X#1#{} Mult',
            [4] = '{C:inactive}rank changes every round{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 9
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    demicolon_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {lenient_bignum(card.ability.extra.xmult), localize((G.GAME.current_round.idol_card or {}).rank or 'Ace', 'ranks')}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round  then
            if context.other_card:get_id() == G.GAME.current_round.idol_card.id then
                return {
                    Xmult = lenient_bignum(card.ability.extra.xmult)
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            G.GAME.current_round.idol_card.rank = 'Ace'
            local valid_cards = {}
            for k, v in ipairs(G.playing_cards) do
                if not SMODS.has_no_rank(v) then
                    valid_cards[#valid_cards+1] = v
                end
            end
            if valid_cards[1] then 
                local idol_card = pseudorandom_element(valid_cards, pseudoseed('idol'..G.GAME.round_resets.ante))
                G.GAME.current_round.idol_card.rank = idol_card.base.value
                G.GAME.current_round.idol_card.id = idol_card.base.id
            end
        end
		if context.forcetrigger then
            return {
                 Xmult = lenient_bignum(card.ability.extra.xmult)
            }
		end
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = math.max(0, G.consumeables.config.card_limit - 1)
            return true
        end }))
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
            return true
        end }))
    end
}

SMODS.Joker{ --Ramen
    key = "ramen",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Ramen',
        ['text'] = {
            [1] = 'All listed {C:green}probabilities{} are',
            [2] = 'Multiplied by {C:green}1000000{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 13
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            local numerator, denominator = context.numerator, context.denominator
            numerator = numerator * (1000000)
            return {
                numerator = numerator, 
                denominator = denominator
            }
        end
    end
}
if Talisman then

SMODS.Joker{ --The Pudding
    key = "thepudding",
    config = {
        extra = {
            operator = 0,
            mult = 1.8
        }
    },
    loc_txt = {
        ['name'] = 'The Pudding',
        ['text'] = {
            [1] = '{X:dark_edition,C:white}#1#{} Mult',
            [2] = '{X:dark_edition,C:white}operator{} increases once if',
            [3] = 'played hand contains a',
            [4] = '{C:attention}Straight Flush{} and {C:attention}7{} of {C:clubs}Clubs{}',
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 8,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 30,
    rarity = "sholium_peculiar",
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' and args.source ~= 'rta' and args.source ~= 'sou' and args.source ~= 'uta' and args.source ~= 'wra' 
            or args.source == 'sho'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {FormatArrowMult(math.ceil(card.ability.extra.operator), card.ability.extra.mult)}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if (next(context.poker_hands["Straight Flush"]) and (function()
                local count = 0
                for _, playing_card in pairs(context.full_hand or {}) do
                    if playing_card:get_id() == 7 then
                        count = count + 1
                    end
                end
                return count >= 1
            end)() and (function()
                local count = 0
                for _, playing_card in pairs(context.full_hand or {}) do
                    if playing_card:is_suit("Clubs") then
                        count = count + 1
                    end
                end
                return count >= 1
            end)()) then
                return {
                    func = function()
                        card.ability.extra.operator = (card.ability.extra.operator) + 1
                        return true
                    end,
                    message = localize('k_upgrade_ex')
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
			if to_big(card.ability.extra.operator) <= to_big(-1) then
				return {
					mult = lenient_bignum(card.ability.extra.mult)
				}
			elseif to_big(card.ability.extra.operator) == to_big(0) then
				return {
                    Xmult = lenient_bignum(card.ability.extra.mult)
				}
			elseif to_big(card.ability.extra.operator) == to_big(1) then
				return {
					emult = lenient_bignum(card.ability.extra.mult)
				}
			elseif to_big(card.ability.extra.operator) == to_big(2) then
				return {
					eemult = lenient_bignum(card.ability.extra.mult)
				}
			elseif to_big(card.ability.extra.operator) > to_big(2) then
				return {
					hypermult = {
						lenient_bignum(math.ceil(card.ability.extra.operator)),
						lenient_bignum(card.ability.extra.mult)
					}
				}
			end
        end
    end
}

end


end
