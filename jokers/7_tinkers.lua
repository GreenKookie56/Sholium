
SMODS.Joker{ --Cobalt Joker
    key = "cobaltjoker",
    config = {
    },
    loc_txt = {
        ['name'] = 'Cobalt Joker',
        ['text'] = {
            [1] = '{C:attention}Retrigger{} the effect of',
            [2] = 'Joker to the right'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 10,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

	calculate = function(self, card, context)

        if context.retrigger_joker then 
            return{
                repetitions = 1,
                retrigger_joker = retrigger_card
            }
        end
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
        local target_joker = nil
        local my_pos = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                my_pos = i
                break
            end
        end
			if context.other_card == G.jokers.cards[my_pos + 1] then
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = card,
				}
			else
				return nil, true
			end
		end
	end,
}

SMODS.Joker{ --Copper Joker
    key = "copperjoker",
    config = {
        extra = {
            multiplier = 0.25,
            base = 1
        }
    },
    loc_txt = {
        ['name'] = 'Copper Joker',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{} Mult for each',
            [2] = 'leftover hands',
            [3] = '{C:inactive}(Currently{} {X:red,C:white}X#2#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 8
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
        
        return {vars = {card.ability.extra.multiplier, card.ability.extra.base + ((G.GAME.current_round.hands_left or 0)) * card.ability.extra.multiplier}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                Xmult = lenient_bignum(card.ability.extra.base + (G.GAME.current_round.hands_left) * card.ability.extra.multiplier)
            }
        end
    end
}


SMODS.Joker{ --Hepatizon Joker
    key = "hepatizonjoker",
    config = {
        extra = {
            rep = 1,
            current = 0
        }
    },
    loc_txt = {
        ['name'] = 'Hepatizon Joker',
        ['text'] = {
            [1] = 'Retrigger all played cards {C:attention}#1#{} time(s)',
            [2] = 'Gains {C:attention}+1{} repetition after playing {C:attention}3{}',
            [3] = 'consecutive hands that',
            [4] = 'contains a {C:attention}Straight{} {C:inactive}(#2#/3){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.rep, card.ability.extra.current}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if (next(context.poker_hands["Straight"]) and to_big(card.ability.extra.current) < to_big(2)) then
                return {
                    func = function()
                        card.ability.extra.current = (card.ability.extra.current) + 1
                        return true
                    end,
                    message = localize('k_upgrade_ex')
                }
            elseif (next(context.poker_hands["Straight"]) and to_big(card.ability.extra.current) >= to_big(2)) then
                return {
                    func = function()
                        card.ability.extra.current = 0
                        return true
                    end,
                    message = localize('k_upgrade_ex'),
                    extra = {
                        func = function()
                            card.ability.extra.rep = (card.ability.extra.rep) + 1
                            return true
                        end,
                        colour = G.C.GREEN
                    }
                }
            elseif not (next(context.poker_hands["Straight"])) then
                return {
                    func = function()
                        card.ability.extra.current = 0
                        return true
                    end,
                    message = localize('k_reset')
                }
            end
        end
        if context.forcetrigger then
            return {
            func = function()
                card.ability.extra.rep = (card.ability.extra.rep) + 1
                return true
            end,
            message = localize('k_upgrade_ex')
            }
        end
        if context.repetition and context.cardarea == G.play then
            return {
                repetitions = card.ability.extra.rep,
                message = localize('k_again_ex')
            }
        end
    end
}

SMODS.Joker{ --Nahuatl Joker
    key = "nahuatljoker",
    config = {
        extra = {
            mod = 1,
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Nahuatl Joker',
        ['text'] = {
            [1] = 'if played hand is exactly {C:attention}3{} cards,',
            [2] = 'This Joker gains {C:mult}+#1#{} Mult and reduces',
            [3] = 'rank of each played card by {C:attention}1{}',
            [4] = 'every time it is triggered',
            [5] = '{C:inactive}(Currently{} {C:red}+#2#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mod, card.ability.extra.mult}}
    end,
    
    calculate = function(self, card, context)
       if context.individual and context.cardarea == G.play and to_big(#context.full_hand) == to_big(3) then
            local scored_card = context.other_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    assert(SMODS.modify_rank(scored_card, -1))
                    return true
                end
            }))
            card.ability.extra.mult = lenient_bignum(card.ability.extra.mult + card.ability.extra.mod)
        end
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                mult = lenient_bignum(card.ability.extra.mult)
            }
        end
    end
}


SMODS.Joker{ --Rose Gold Joker
    key = "rosegoldjoker",
    config = {
        extra = {
			chips = 0.7,
			immutable = {
                slots = 2
			}
        }
    },
    loc_txt = {
        ['name'] = 'Rose Gold Joker',
        ['text'] = {
            [1] = '{C:attention}+#2#{} Consumable slots',
            [2] = '{X:chips,C:white}X#1#{} Chips'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chips, card.ability.extra.immutable.slots}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and not context.blueprint then
            return {
                x_chips = card.ability.extra.chips
            }
        end
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.immutable.slots
            return true
        end }))
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.immutable.slots
            return true
        end }))
    end
}

SMODS.Joker{ --Manyullyn Joker
    key = "manyullynjoker",
    config = {
        extra = {
            mult = 1,
            mod = 0.05
        }
    },
    loc_txt = {
        ['name'] = 'Manyullyn Joker',
        ['text'] = {
            [1] = 'When each played card is scored,',
            [2] = '{X:red,C:white}X#1#{} Mult and increase this by {X:red,C:white}#2#{}',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mult, card.ability.extra.mod}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play or context.forcetrigger then
            card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mod
            return {
                Xmult = card.ability.extra.mult
            }
        end
    end
}
