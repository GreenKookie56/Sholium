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
            [3] = 'Creates a copy of this card if sold',
            [4] = 'at more than {C:money}$30{} of sell value',
            [5] = '{C:inactive}The Three\'s endowed?{}'
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
    eternal_compat = false,
    perishable_compat = false,
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

        if context.selling_self and to_big(card.sell_cost) >= to_big(30) and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local card = create_card('j_sholium_thetreeisloud', G.jokers, nil, nil, nil, nil, 'j_sholium_thetreeisloud', 'thetreeisloud')
                    card:set_cost()
                    card:add_to_deck() 
                    G.jokers:emplace(card)
                    card:start_materialize()
                    return true
                end
            }))
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE}) 
        end -- bloonlatro op

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
