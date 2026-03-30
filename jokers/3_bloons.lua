SMODS.Joker{ --Bloon Exclusion Zone (v38+)
    key = "bez",
    config = {
        extra = {
            scored = 0,
            pb_mult_7e6bb471 = 6,
            perma_mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Bloon Exclusion Zone (v38+)',
        ['text'] = {
            [1] = 'Every scored {C:spades}Spades{}',
            [2] = 'permanently gains {C:red}+6{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Spades") then
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.pb_mult_7e6bb471
                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.MULT }, card = card
                }
            end
        end
    end
}
SMODS.Joker{ --Bloonchipper
    key = "bloonchipper",
    config = {
        extra = {
            discard = 0,
            discardmod = 1,
            round = 0
        }
    },
    loc_txt = {
        ['name'] = 'Bloonchipper',
        ['text'] = {
            [1] = '{C:red}+#1#{} discard(s)',
            [2] = 'when {C:attention}Blind{} is selected',
            [3] = 'Increase by {C:red}+#2#{} each {C:attention}Ante{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 7,
        y = 0
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
        return {vars = {card.ability.extra.discard, card.ability.extra.discardmod}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.discard = (card.ability.extra.discard) + card.ability.extra.discardmod
                    return true
                end,
                    message = localize('k_upgrade_ex')
                }
        end
        if context.setting_blind  then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.discard).." Discard", colour = G.C.ORANGE})
                G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + card.ability.extra.discard
                return true
            end
                }
        end
        if context.forcetrigger then
          return {
            func = function()
                card.ability.extra.discard = (card.ability.extra.discard) + card.ability.extra.discardmod    
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.discard).." Discard", colour = G.C.ORANGE})
                G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + card.ability.extra.discard
                return true
            end
                }
        end
    end
}
SMODS.Joker{ --Boss Farming Guide
    key = "bossfarmingguide",
    config = {
        extra = {
            eor = 2,
            thenumerator = 1,
            money÷10 = 0
        }
    },
    loc_txt = {
        ['name'] = 'Boss Farming Guide',
        ['text'] = {
            [1] = 'Earn {C:gold}$#1#{} at the end of round',
            [2] = 'Payout increases by {C:gold}$1{} for every {C:gold}$10{}',
            [3] = 'you have at the end of round'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 8,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 11,
    rarity = 3,
    blueprint_compat = false,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.eor}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.eor = lenient_bignum(card.ability.extra.eor) + lenient_bignum(math.floor(math.max(G.GAME.dollars / 10) , 0))
                    return true
                end,
                    message = localize('k_upgrade_ex'),
                    extra = {
                        colour = G.C.MONEY
                        }
                }
        end
        if context.forcetrigger then
            card.ability.extra.eor = lenient_bignum(card.ability.extra.eor) + lenient_bignum(math.floor(math.max(G.GAME.dollars / 10) , 0))
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

SMODS.Joker{ --Carrier Flagship
    key = "carrierflagship",
    config = {
        extra = {
            chips = 3,
            odds = 3
        }
    },
    loc_txt = {
        ['name'] = 'Carrier Flagship',
        ['text'] = {
            [1] = 'Each played {C:clubs}Clubs{} has a',
            [2] = '{C:green}#2# in #3#{} chance to {X:blue,C:white}X#1#{} Chips',
            [3] = 'when scored',
            [4] = '{C:inactive}Let\'s go gambling!{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 1
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
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sholium_carrierflagship') 
        return {vars = {card.ability.extra.chips, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Clubs") then
                if SMODS.pseudorandom_probability(card, 'group_0_86561525', 1, card.ability.extra.odds, 'j_sholium_carrierflagship', false) then
                    x_chips = card.ability.extra.chips
                end
            end
        end
        if context.forcetrigger then
            return {
                x_chips = card.ability.extra.chips
            }
        end
    end
}
SMODS.Joker{ --Free Dart Monkey
    key = "freedartmonkey",
    config = {
        extra = {
            chips = 30,
            mult = 2,
            cash = 1
        }
    },
    loc_txt = {
        ['name'] = 'Free Dart Monkey',
        ['text'] = {
            [1] = '{C:blue}+#1#{} Chips',
            [2] = '{C:red}+#2#{} Mult',
            [3] = 'Earn {C:gold}$#3#{} when bought'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 9,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 1,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
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
        return {vars = {card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.cash}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    chips = card.ability.extra.chips,
                    extra = {
                        mult = card.ability.extra.mult
                        }
                }
        end
        if context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers  then
                return {
                    dollars = card.ability.extra.cash
                }
        end
    end
}
SMODS.Joker{ --Glaive Lord
    key = "glaivelord",
    config = {
        extra = {
            chips = 0,
            chipsmod = 3,
            first = 1
        }
    },
    loc_txt = {
        ['name'] = 'Glaive Lord',
        ['text'] = {
            [1] = 'This Joker gains {C:blue}+#2#{} Chips',
            [2] = 'for each {C:attention}non-first{} scored card',
            [3] = 'of every {C:attention}hand{}{}',
            [4] = '{C:inactive}(Currently {}{C:blue}+#1#{}{C:inactive} Chips){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 2,
        y = 2
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
    soul_pos = {
        x = 3,
        y = 2
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, card.ability.extra.chipsmod}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if (card.ability.extra.first or 0) == 1 then
                card.ability.extra.first = 0
            elseif (card.ability.extra.first or 0) ~= 1 then
                card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.chipsmod
                return {
                    message = localize('k_upgrade_ex')
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.chips
                }
        end
        if context.after and context.cardarea == G.jokers  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.first = 1
                    return true
                end
                }
        end
        if context.forcetrigger then
	SMODS.scale_card(card, {
		ref_table = card.ability.extra,
		ref_value = "chips",
		scalar_value = "chipsmod",
		message_colour = G.C.BLUE,
			})
	return {
                    chips = card.ability.extra.chips
            }
        end
    end
}
SMODS.Joker{ --Jugger nut Hole
    key = "juggernuthole",
    config = {
        extra = {
            repetitions = 6
        }
    },
    loc_txt = {
        ['name'] = 'Jugger nut Hole',
        ['text'] = {
            [1] = 'If played hand contains',
            [2] = '{C:attention}Five of a Kind{} or {C:attention}Flush House{},',
            [3] = '{C:attention}Retrigger{} all played cards {C:attention}#1#{} times'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 9,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'sho' 
          or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.repetitions}}
    end,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if (next(context.poker_hands["Five of a Kind"]) or next(context.poker_hands["Flush House"])) then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}

SMODS.Joker{ --Pop and Awe
    key = "popandawe",
    config = {
		extra = {
			chips = 8,
			xchips = 3
		}
    },
    loc_txt = {
        ['name'] = 'Pop and Awe',
        ['text'] = {
            [1] = '{C:blue}-#1#{} Chips',
            [2] = '{X:blue,C:white}X#2#{} Chips'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 8,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
	
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chips, card.ability.extra.xchips}}
    end,
	
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    chips = -card.ability.extra.chips,
                    extra = {
                        x_chips = card.ability.extra.xchips,
                        colour = G.C.DARK_EDITION
                        }
                }
        end
    end
}

SMODS.Joker{ --Riptide Champion (v52)
    key = "ripchamp",
    config = {
        extra = {
            mod = 0.3,
            chips = 1
        }
    },
    loc_txt = {
        ['name'] = 'Riptide Champion (v52)',
        ['text'] = {
            [1] = 'This Joker gains {X:blue,C:white}X#1#{} Chips',
            [2] = 'when each played card is scored',
            [3] = '{C:attention}Resets{} at end of round',
            [4] = '{C:inactive}(Currently{} {X:blue,C:white}X#2#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
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
        
        return {vars = {card.ability.extra.mod, card.ability.extra.chips}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.mod
            return {
                message = localize('k_upgrade_ex')
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                x_chips = card.ability.extra.chips
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.chips = 1
                    return true
                end,
                message = localize("k_reset")
            }
        end
        if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "mod",
			})
			return {
				Xchip_mod = lenient_bignum(card.ability.extra.chips),
			}
        end
    end
}
SMODS.Joker{ --:squalch:
    key = "squalch",
    config = {
        extra = {
            chips = 4,
            squarechips = 16
        }
    },
    loc_txt = {
        ['name'] = ':squalch:',
        ['text'] = {
            [1] = '{C:blue}+#2#{} Chips',
            [2] = '{C:attention}Quadratically{} increases',
            [3] = 'if first played hand has',
            [4] = 'exactly {C:attention}4{} {C:spectral}scoring{} cards',
            [5] = '{C:inactive,s:0.7}(ex. +16, +25, +36, +49...){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 0
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
        return {vars = {card.ability.extra.chips, card.ability.extra.squarechips}}
    end,

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  then
            if (#context.scoring_hand == 4 and G.GAME.current_round.hands_played == 0) then
                local squarechips_value = card.ability.extra.squarechips
                return {
                    func = function()
                    card.ability.extra.chips = (card.ability.extra.chips) + 1
                    return true
                end,
                    extra = {
                        func = function()
                    card.ability.extra.squarechips = card.ability.extra.chips
                    return true
                end,
                        colour = G.C.BLUE,
                        extra = {
                            func = function()
                    card.ability.extra.squarechips = (card.ability.extra.squarechips) * card.ability.extra.chips
                    return true
                end,
                            message = localize('k_upgrade_ex'),
                            colour = G.C.MULT
                        }
                        }
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
                return {
                    chips = card.ability.extra.squarechips
                }
        end
        if context.forcetrigger then
            card.ability.extra.chips = (card.ability.extra.chips) + 1
            card.ability.extra.squarechips = (card.ability.extra.chips) * card.ability.extra.chips
            return {
                chips = card.ability.extra.squarechips
            }
        end
    end
}
SMODS.Joker{ --The Blazing Sun (v49)
    key = "theblazingsun",
    config = {
        extra = {
            Remaining = 4,
        }
    },
    loc_txt = {
        ['name'] = 'The Blazing Sun (v49)',
        ['text'] = {
            [1] = '{C:red}+55{} Mult every {C:attention}5th{} hand',
            [2] = '{C:blue}+12{} Chips otherwise',
            [3] = '{C:inactive}#1# remaining{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 6,
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
        return {vars = {card.ability.extra.Remaining}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (card.ability.extra.Remaining or 0) <= 0 then
                card.ability.extra.Remaining = 4
                return {
                    mult = 55
                }
            else
                card.ability.extra.Remaining = math.max(0, (card.ability.extra.Remaining) - 1)
                return {
                    chips = 12
                }
            end
        end
        if context.forcetrigger then
            return {
                mult = 55
            }
        end
    end
}

SMODS.Joker{ --Tricky tracks
    key = "trickytracks",
    config = {
        extra = {
            mult = 1,
            scale = 0.3
        }
    },
    loc_txt = {
        ['name'] = 'Tricky tracks',
        ['text'] = {
            [1] = '{X:red,C:white}XMult{} increases once if',
            [2] = 'played hand is {C:attention}Three of a Kind{}',
            [3] = '{X:red,C:white}XMult{} scales faster the further',
            [4] = 'it is away from {X:red,C:white}X3{} Mult',
            [5] = '{C:inactive}(Currently {}{X:red,C:white}X#1#{}{C:inactive} Mult, increases by{} {X:red,C:white}#2#{}{C:inactive}){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 6
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
            if context.scoring_name == "Three of a Kind" then
                return {
                    func = function()
                        card.ability.extra.mult = lenient_bignum(card.ability.extra.mult) + lenient_bignum(card.ability.extra.scale)
                        return true
                    end,
                    message = "Upgrade!",
                    extra = {
                        func = function()
                            card.ability.extra.scale = lenient_bignum(math.abs(3 - card.ability.extra.mult) * 0.1 + 0.1)
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.mult
            }
        end
        if context.forcetrigger then
            return {
                func = function()
                        card.ability.extra.mult = lenient_bignum(card.ability.extra.mult) + lenient_bignum(card.ability.extra.scale)
                        return true
                end,
                message = localize('k_upgrade_ex'),
                extra = {
                    func = function()
                        card.ability.extra.scale = lenient_bignum(math.abs(3 - card.ability.extra.mult) * 0.1 + 0.1)
                        return true
                    end,
                    colour = G.C.BLUE
                    },
                Xmult = card.ability.extra.mult
                }
        end
    end
}


SMODS.Joker{ --Water Tower
    key = "watertower",
    config = {
        extra = {
            mult = 0,
            multmod = 2
        }
    },
    loc_txt = {
        ['name'] = 'Water Tower',
        ['text'] = {
            [1] = 'This Joker gains {C:red}+#2#{} Mult if',
            [2] = 'played hand is not your',
            [3] = '{C:attention}most played{} Poker Hand',
            [4] = '{C:inactive}(Currently{} {C:red}+#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
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
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mult, card.ability.extra.multmod}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if (function()
                local current_played = G.GAME.hands[context.scoring_name].played or 0
                for handname, values in pairs(G.GAME.hands) do
                    if handname ~= context.scoring_name and values.played >= current_played and values.visible then
                        return true
                    end
                end
                return false
            end)() then
                return {
                    message = localize('k_upgrade_ex'),
                    func = function()
                        card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.multmod
                        return true
                    end
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.forcetrigger then
            local mult_value = card.ability.extra.mult
            card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.multmod
             return {
                mult = mult_value
            }
        end
    end
}
	
if Talisman then
	
if Cryptid then --Cryptlib
SMODS.Joker{ --tt5
    key = "tt5bug",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Total transformation bug (v38)',
        ['text'] = {
            [1] = '{C:attention}Force-trigger{} Joker to the {C:attention}right{}',
            [2] = 'when Joker to the {C:attention}left{} is triggered',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 30,
    rarity = "sholium_peculiar",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
	soul_pos = { x = 5, y = 7, extra = { x = 6, y = 7 } },
    
    calculate = function(self, card, context)
        if context.post_trigger then
            local left_joker = nil
            for k, v in ipairs(G.jokers.cards) do
                if v == card then
                    if k > 1 then
                        left_joker = G.jokers.cards[k - 1]
                    end
                end
            end
            if left_joker and context.other_card == left_joker then
			    for i = 1, #G.jokers.cards do
				    if G.jokers.cards[i] == card then
					    if Cryptid.demicolonGetTriggerable(G.jokers.cards[i + 1])[1] then
						    local results = Cryptid.forcetrigger(G.jokers.cards[i + 1], context)
						    if results and results.jokers then
							    return results.jokers
						    end
						end
					end
				end
			end
        end
    end
}
end

if next(SMODS.find_mod("Cryptid")) then -- Cryptid

SMODS.Joker{ --Overclock
    key = "overclock",
    config = {
        extra = {
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'Overclock',
        ['text'] = {
            [1] = 'Create a {C:dark_edition}Negative{}',
            [2] = '{C:attention}Boss Farming Guide{}',
            [3] = 'at the end of {C:green}shop{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 3
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

    calculate = function(self, card, context)
        if context.ending_shop or context.forcetrigger then
                return {
                    func = function()
            local created_joker = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_bossfarmingguide' })
                    if joker_card then
                        joker_card:set_edition("e_negative", true)
                        
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
end
end
