if Sholium.config.sholextra then

if Talisman then
SMODS.Joker{ --Ancient meme
    key = "ancientmeme",
    config = {
    },
    loc_txt = {
        ['name'] = 'Ancient meme',
        ['text'] = {
            [1] = '{X:money,C:dark_edition}=$939{} when {C:green}shop{} is {C:attention}rerolled{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 3,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 30,
    rarity = "sholium_peculiar",
    blueprint_compat = false,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.reroll_shop or context.forcetrigger then
                return {
                    func = function()
                    local target_amount = 939
                    local current_amount = G.GAME.dollars
                    local difference = target_amount - current_amount
                    ease_dollars(difference)
                    return true
                end
                }
        end
    end
}
end
SMODS.Joker{ --Avrejer
    key = "avenger",
    config = {
	    extra = {
			hands = 1
		}
    },
    loc_txt = {
        ['name'] = 'Avenger (v52)',
        ['text'] = {
            [1] = '{C:blue}+#1#{} hand this round if played',
            [2] = '{C:attention}poker hand{} has already been',
            [3] = 'played this round before',
            [4] = '{C:inactive}Ah yes common pt.2{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 7
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
        return {vars = {card.ability.extra.hands}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before then
            if G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1 then
                return {
                    func = function()
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(1).." Hands", colour = G.C.GREEN})
                        G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.hands
                        return true
                    end
                }
            end
        end
		if context.forcetrigger then
		    G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.hands
		end
    end
}
SMODS.Joker{ --bugged blitz
    key = "buggedblitz",
    config = {
        extra = {
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'Bugged Blitz (v49)',
        ['text'] = {
            [1] = 'Sell this card to {C:red}destroy{}',
            [2] = 'all cards {C:attention}held in hand{}',
            [3] = 'and create a {C:attention}copy{} of this joker'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 14
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.selling_self  and not context.blueprint then
                return {
                    func = function()
            local created_joker = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    play_sound('tarot1')
                    card:start_dissolve()
                    return true
                end
            }))
            local destroyed_cards = {}
            for k, v in ipairs(G.hand.cards) do
                destroyed_cards[#destroyed_cards+1] = v
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function() 
                    for i=#destroyed_cards, 1, -1 do
                        local card = destroyed_cards[i]
                        if card.ability.name == 'Glass Card' then 
                            card:shatter()
                        else
                            card:start_dissolve(nil, i == #destroyed_cards)
                        end
                    end
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_buggedblitz' })
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
SMODS.Joker{ --Doreo stream
    key = "doreostream",
    config = {
        extra = {
            source_rank_type = "all",
            target_rank = "7"
        }
    },
    loc_txt = {
        ['name'] = 'Doreo stream',
        ['text'] = {
            [1] = 'All cards count as {C:attention}7s{}',
            [2] = '{C:inactive,s:0.7}\"new pixel art for sholatro joker\"{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
    end,

    add_to_deck = function(self, card, from_debuff)
        -- Combine ranks effect enabled
    end,

    remove_from_deck = function(self, card, from_debuff)
        -- Combine ranks effect disabled
    end
}


local card_get_id_ref = Card.get_id
function Card:get_id()
    local original_id = card_get_id_ref(self)
    if not original_id then return original_id end

    if next(SMODS.find_card("j_sholium_doreostream")) then
        return 7
    end
    return original_id
end
SMODS.Joker{ --Galvanic Conduit (v56)
    key = "galvanicconduit",
    config = {
        extra = {
            multmod = 5,
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Galvanic Conduit (v56)',
        ['text'] = {
            [1] = 'This Joker gains {C:red}+#1#{} Mult',
            [2] = '{C:attention}this round{} for every',
            [3] = '{C:attention}non-scoring{} cards',
            [4] = 'contained in played hand',
            [5] = '{C:inactive}(Currently{} {C:red}+#2#{} {C:inactive}Mult){}',
            [6] = '{C:inactive}ah yes common pt.3{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 14
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
        
        return {vars = {card.ability.extra.multmod, card.ability.extra.mult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.cardarea == G.jokers and context.before and not context.blueprint then
			cards = 0
			for k, v in ipairs(context.scoring_hand) do
				v.scoring = true
			end
			for k, v in ipairs(context.full_hand) do
				if not v.scoring then
					cards = cards + 1
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end,
					}))
				end
			end
			for k, v in ipairs(context.scoring_hand) do
				v.scoring = nil
			end
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multmod * cards
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.mult = 0
                    return true
                end
            }
        end
    end
}

SMODS.Joker{ --Geraldo (v31.0)
    key = "geraldo",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Geraldo (v31.0)',
        ['text'] = {
            [1] = 'Create a random {C:attention}Tag{}',
            [2] = 'when {C:green}shop{} is {C:attention}rerolled{}',
            [3] = '{C:inactive}Ah yes common{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 4,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    demicoloncompat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.reroll_shop or context.forcetrigger then
                return {
                    func = function()
            G.E_MANAGER:add_event(Event({
                func = function()
                    local selected_tag = pseudorandom_element(G.P_TAGS, pseudoseed("create_tag")).key
                    local tag = Tag(selected_tag)
                    if tag.name == "Orbital Tag" then
                        local _poker_hands = {}
                        for k, v in pairs(G.GAME.hands) do
                            if v.visible then
                                _poker_hands[#_poker_hands + 1] = k
                            end
                        end
                        tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                    end
                    tag:set_ability()
                    add_tag(tag)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
                    return true
                end,
                    message = "heaps of dev and balance time"
                }
        end
    end
}
SMODS.Joker{ --Grilled chicken
    key = "grilledchicken",
    config = {
        extra = {
            chicken = 0,
        }
    },
    loc_txt = {
        ['name'] = 'Grilled chicken',
        ['text'] = {
            [1] = 'Instead of owning stuff,',
            [2] = 'eat {C:attention}grilled chicken{}',
            [3] = '{C:inactive}(Currently {}{X:attention,C:white}#1#{}{C:inactive} Grilled Chicken){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 14
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chicken}}
    end,

    calculate = function(self, card, context)
        if context.selling_card  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.chicken = (card.ability.extra.chicken) + 1
                    return true
                end,
                message = '+1 Grilled Chicken',
            }
        end
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                Xmult = 1 + 0.1 * card.ability.extra.chicken
            }
        end
    end
}
SMODS.Joker{ --Ground Zero (v18-29)
    key = "groundzero",
    config = {
        extra = {
            chips = 700
        }
    },
    loc_txt = {
        ['name'] = 'Ground Zero (v18-29)',
        ['text'] = {
            [1] = '{C:blue}+#1#{} Chips for the',
            [2] = 'first hand of the round',
            [3] = '{s:0.8,C:inactive}this looks familiar{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 2
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
        return {vars = {card.ability.extra.chips}}
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
        if context.forcetrigger then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
SMODS.Joker{ --Horseboard
    key = "horseboard",
    config = {
	    extra = {
			mult = 1	
		}
    },
    loc_txt = {
        ['name'] = 'Horseboard',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{} Mult',
            [2] = 'for every {C:attention}horse react{} in',
            [3] = '{C:dark_edition}Bloonlatro horseboard{}',
            [4] = '(in sholatro-ideas, Bloonlatro server)',
            [5] = '{C:inactive}(Currently{} {X:red,C:white}X#2#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 6
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
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, 9 * card.ability.extra.mult}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
                return {
                    Xmult = lenient_bignum(card.ability.extra.mult * 9)
                }
        end
        if context.forcetrigger then
                return {
                    Xmult = lenient_bignum(card.ability.extra.mult * 9)
                }
        end
    end
}
SMODS.Joker{ --Ploone
    key = "ploone",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Ploone',
        ['text'] = {
            [1] = 'Create a {C:dark_edition}Negative{} {C:attention}Lucky Cat{}',
            [2] = 'at the end of {C:attention}shop{}',
            [3] = '{C:inactive}Art & Design by Ic1clez_{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 2,
        y = 6
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

    calculate = function(self, card, context)
        if context.ending_shop or context.forcetrigger then
                return {
                    func = function()
            local created_joker = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_lucky_cat' })
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

SMODS.Joker{ --Red Sauda
    key = "redsauda",
    loc_txt = {
        ['name'] = 'Red Sauda (v46+)',
        ['text'] = {
            [1] = 'Swap {C:blue}Chips{} and {C:red}Mult{}',
            [2] = 'before hand starts scoring',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2, y = 7 -- bulgoe reference!!
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
    
    calculate = function(self, card, context)
        if context.initial_scoring_step or context.forcetrigger then
            return {
                swap = true
            }
        end
    end
}
SMODS.Joker{ --Sheppi
    key = "sheppi",
    config = {
        extra = {
            chips = 1,
            chipscale = 0.02
        }
    },
    loc_txt = {
        ['name'] = 'Sheppi',
        ['text'] = {
            [1] = 'When a {C:hearts}Heart{} is played and scored,',
            [2] = '{X:blue,C:white}X#1#{} Chips and increase this by {X:blue,C:white}#2#{}',
            [3] = '{C:inactive}Art & Design by Ic1clez_{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, card.ability.extra.chipscale}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Hearts") then
                local chips_value = card.ability.extra.chips
                card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.chipscale
                return {
                    x_chips = chips_value,
                    extra = {
                        message = "Upgrade!",
                        colour = G.C.GREEN
                        }
                }
            end
        end
    end
}
SMODS.Joker{ --Shiniest award (v38)
    key = "shiniestaward",
    config = {
        extra = {
            req = 38,
            played = 0
        }
    },
    loc_txt = {
        ['name'] = 'Shiniest award (v38)',
        ['text'] = {
            [1] = '{C:red}+2,000,000{} Mult only',
            [2] = 'after playing {C:attention}#1#{} hands',
            [3] = '{C:inactive}(#2#/#1#){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 6,
        y = 6
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.req, card.ability.extra.played}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (card.ability.extra.played or 0) >= card.ability.extra.req then
                return {
                    mult = 2000000
                }
            else
                card.ability.extra.played = (card.ability.extra.played) + 1
                return {
                    message = "Update!"
                }
            end
        end
        if context.forcetrigger then
            return {
                mult = 2000000
            }
        end
    end
}
SMODS.Joker{ --tb1 faster firing
    key = "tb1fasterfiring",
    config = {
        extra = {
            scoring = 1
        }
    },
    loc_txt = {
        ['name'] = 'tb1 faster firing',
        ['text'] = {
            [1] = 'This Joker gains {X:blue,C:white}X0.3{} Chips',
            [2] = 'if played hand contains',
            [3] = '{C:attention}5{} scoring cards',
            [4] = 'resets at the end of ante',
            [5] = '{C:inactive}(Currently{} {X:blue,C:white}X#1#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 14
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
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.scoring}}
    end,

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if #context.scoring_hand >= 5 then
                return {
                    func = function()
                    card.ability.extra.scoring = (card.ability.extra.scoring) + 0.3
                    return true
                end,
                    message = localize('k_upgrade_ex'),
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    x_chips = card.ability.extra.scoring
                }
        end
        if context.end_of_round and context.main_eval and G.GAME.blind.boss and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.scoring = 1
                    return true
                end,
                message = localize("k_reset")
            }
        end
    end
}
SMODS.Joker{ --tb1 burny stuff
    key = "tb1burnystuff",
    config = {
        extra = {
            scoring = 1,
            cd = 4
        }
    },
    loc_txt = {
        ['name'] = 'tb1 burny stuff',
        ['text'] = {
            [1] = 'This Joker gains {X:red,C:white}X1.5{} Mult',
            [2] = 'after {C:attention}#2#{} played hands',
            [3] = 'that contain {C:attention}5{} scoring cards',
            [4] = 'resets at the end of ante',
            [5] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 14
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
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.scoring, card.ability.extra.cd}}
    end,

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if (#context.scoring_hand >= 5 and (card.ability.extra.cd or 0) > 1) then
                return {
                    func = function()
                    card.ability.extra.cd = math.max(0, (card.ability.extra.cd) - 1)
                    return true
                end
                }
            elseif (#context.scoring_hand >= 5 and (card.ability.extra.cd or 0) <= 1) then
                return {
                    func = function()
                    card.ability.extra.scoring = (card.ability.extra.scoring) + 1.5
                    return true
                end,
                    message = localize('k_upgrade_ex'),
                    extra = {
                        func = function()
                    card.ability.extra.cd = 4
                    return true
                end,
                        colour = G.C.BLUE
                        }
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    Xmult = card.ability.extra.scoring
                }
        end
        if context.end_of_round and context.main_eval and G.GAME.blind.boss and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.scoring = 1
                    return true
                end,
                message = localize("k_reset")
            }
        end
    end
}
SMODS.Joker{ --Vrejdilum
    key = "vrejdilum",
    config = {
    },
    loc_txt = {
        ['name'] = 'Vrejdilum',
        ['text'] = {
            [1] = 'This Joker gives {C:blue}+1{} Chips',
            [2] = 'for every message',
            [3] = 'that contains \"{C:attention}vrej{}\" in',
            [4] = '{C:attention}Puddles of Pudding{} server',
            [5] = '{C:inactive}latest update: Oct 2 2026{}',
            [6] = '{C:inactive}(Currently{} {C:blue}+781{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 14
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 16,
    rarity = 3,
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

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    chips = 781
                }
        end
    end
}
SMODS.Joker{ --The Fungus
    key = "thefungus",
    config = {
        extra = {
            operator = -1
        }
    },
    loc_txt = {
        ['name'] = 'The Fungus',
        ['text'] = {
            [1] = 'Destroy a random {C:attention}Joker{} when {C:attention}Blind{} is selected',
            [2] = 'and add the Joker\'s {C:attention}sell value{} to {X:dark_edition,C:white}operator{}',
            [3] = '(Currently {X:dark_edition,C:white}#1#{} Chips)',
            [4] = '{s:0.8,C:inactive}wait this is NOT the expert{}',
            [5] = '{C:inactive}Art by 1.2m^2 Fungus Room{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 7,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 30,
    rarity = "sholium_peculiar",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    loc_vars = function(self, q, card)
        return {
            vars = {
                FormatArrowMult(card.ability.extra.operator, 5)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind  and not context.blueprint then
                return {
                    func = function()
                local destructable_jokers = {}
                for i, joker in ipairs(G.jokers.cards) do
                    if joker ~= card and not joker.ability.eternal and not joker.getting_sliced then
                        table.insert(destructable_jokers, joker)
                    end
                end
                local target_joker = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('destroy_joker')) or nil
                
                if target_joker then
                    local joker_sell_value = target_joker.sell_cost or 0
                    local sell_value_gain = joker_sell_value
                    card.ability.extra.operator = card.ability.extra.operator + sell_value_gain
                    target_joker.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                end
                    return true
                end
                }
        end
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
			if to_big(card.ability.extra.operator) <= to_big(-1) then
				return {
					chips = 5
				}
			elseif to_big(card.ability.extra.operator) == to_big(0) then
				return {
                    x_chips = 5
				}
			elseif to_big(card.ability.extra.operator) == to_big(1) then
				return {
					echips = 5
				}
			elseif to_big(card.ability.extra.operator) == to_big(2) then
				return {
					eechips = 5
				}
			elseif to_big(card.ability.extra.operator) >= to_big(3) then
				return {
					hyperchips = {
						lenient_bignum(card.ability.extra.operator),
						5
					}
				}
			end
        end
    end
}
end