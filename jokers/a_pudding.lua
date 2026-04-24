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
            mult_mod = 2,
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
            eor_mod = 0.5
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
            [2] = '{C:attention}Doubles{} value of Joker to the {C:attention}right{},',
            [3] = '{C:attention}Halves{} value of Joker to the {C:attention}left{}',
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
							Cryptid.manipulate(G.jokers.cards[i + 1], { value = 2 })
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
if Talisman then

SMODS.Joker{ --The Pudding
    key = "thepudding",
    config = {
        extra = {
            operator = 0,
            mult = 1.7
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
