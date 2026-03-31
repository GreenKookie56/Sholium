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
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Set to $"..tostring(card.ability.extra.dollars), colour = G.C.MONEY})
                    return true
                end
                }
        end
    end
}
end
SMODS.Joker{ --Cave Monkey
    key = "cavemonkey",
    loc_txt = {
        ['name'] = 'Cave Monkey',
        ['text'] = {
            [1] = 'Add a {C:dark_edition}Negative{} {C:red}Red Seal{} Stone card to hand',
            [2] = 'when a Blind is selected',
            [3] = '{C:inactive}Me Hit Rock{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.setting_blind or context.forcetrigger then
                return {
                    func = function()
                local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card_hand'))
                local new_card = create_playing_card({
                    front = card_front,
                    center = G.P_CENTERS.m_stone
                }, G.discard, true, false, nil, true)
            new_card:set_seal("Red", true)
            new_card:set_edition("e_negative", true)
                
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                new_card.playing_card = G.playing_card
                table.insert(G.playing_cards, new_card)
                
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand:emplace(new_card)
                        new_card:start_materialize()
                        SMODS.calculate_context({ playing_card_added = true, cards = { new_card } })
                        return true
                    end
                }))
            end,
                    message = "Added Card to Hand!"
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
        return {vars = {card.ability.extra.mult, 8 * card.ability.extra.mult}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
                return {
                    Xmult = lenient_bignum(card.ability.extra.mult * 8)
                }
        end
        if context.forcetrigger then
                return {
                    Xmult = lenient_bignum(card.ability.extra.mult * 8)
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
            [2] = 'when the {C:attention}first{} played',
            [3] = 'card is triggered'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 7
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
        if context.individual and context.cardarea == G.play  then
            if context.other_card == context.scoring_hand[1] then
                return {
                    swap = true
                }
            end
        end
        if context.forcetrigger then
            return {
                swap = true
            }
        end
    end
}

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
        if context.cardarea == G.jokers and context.before or context.forcetrigger then
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

-- nice self insert bro
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
        
        return {vars = {FormatArrowMult(card.ability.extra.operator, card.ability.extra.mult)}}
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
			elseif to_big(card.ability.extra.operator) >= to_big(3) then
				return {
					hypermult = {
						lenient_bignum(card.ability.extra.operator),
						lenient_bignum(card.ability.extra.mult)
					}
				}
			end
        end
    end
}

end
end
