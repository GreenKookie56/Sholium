SMODS.Joker{ --A deck
    key = "adeck",
    config = {
    },
    loc_txt = {
        ['name'] = 'A deck',
        ['text'] = {
            [1] = 'Gives {C:blue}Chips{} equals the total amount',
            [2] = 'of Chips a {C:attention}standard 52-card deck{}',
            [3] = 'provides {C:inactive}(+380){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 16,
    rarity = 2,
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
                    chips = 380
                }
        end
    end
}

SMODS.Joker{ --Chocolatebar Quotes
    key = "chocolatebarquotes",
    config = {
    },
    loc_txt = {
        ['name'] = 'Chocolatebar Quotes',
        ['text'] = {
            [1] = 'In today\'s {C:attention}video{}, {C:attention}five{} of my friends',
            [2] = 'try {C:attention}hunt{} me down and {C:attention}stop{} me',
            [3] = 'from beating {C:attention}Minecraft{}.',
            [4] = 'Can they stop me from beating the',
            [5] = '{C:dark_edition}ender dragon{} or will I {C:attention}survive{}?',
            [6] = 'This is it, {C:blue}Minecraft manhunt versus 5 hunters{},',
            [7] = 'the finale. Also, only a {C:green}small percentage{}',
            [8] = 'of people that watch my videos',
            [9] = 'are actually {C:attention}subscribed{}, so consider subscribing.',
            [10] = 'it\'s {C:green}free{} and you can always change your mind later.',
            [11] = '{C:attention}Enjoy.{}',
            [12] = '{C:inactive}(Actual effect: add one Mult {}',
            [13] = '{C:inactive}for every quote that\'s sent to cbqpl {}',
            [14] = '{C:inactive}as of 2025 August 1st 11:45 UTC+8){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 2,
        y = 1
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

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    mult = 72
                }
        end
    end
}

SMODS.Joker{ --Clubism
    key = "clubism",
    config = {
    },
    loc_txt = {
        ['name'] = 'Clubism',
        ['text'] = {
            [1] = 'Increase level of played',
            [2] = '{C:attention}poker hand{} if played hand',
            [3] = 'contains a scoring {C:clubs}Clubs{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
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
        if context.cardarea == G.jokers and context.before then
            if (function()
                local count = 0
                for _, playing_card in pairs(context.scoring_hand or {}) do
                    if playing_card:is_suit("Clubs") then
                        count = count + 1
                    end
                end
                return count >= 1
            end)() then
                local target_hand = (context.scoring_name or "High Card")
                return {
                    level_up = true,
                    message = localize('k_level_up_ex')
                }
            end
        end
    end
}
SMODS.Joker{ --Flash
    key = "flash",
    config = {
        extra = {
            xmult = 1,
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'Flash',
        ['text'] = {
            [1] = 'Create a {C:attention}Flash Card{}',
            [2] = 'when {C:green}shop{} is {C:attention}rerolled{}',
            [3] = 'Each {C:attention}Flash Card{} gives {X:red,C:white}X#1#{} Mult',
            [4] = 'increase {X:red,C:white}XMult{} value by {X:red,C:white}0.5{}',
            [5] = 'when shop is rerolled'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 1
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
    soul_pos = {
        x = 8,
        y = 1
    },
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' and args.source ~= 'rta' and args.source ~= 'sou' and args.source ~= 'uta' and args.source ~= 'wra' 
          or args.source == 'sho'
          )
          and true
      end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult}}
    end,

    calculate = function(self, card, context)
        if context.reroll_shop or context.forcetrigger then
                return {
                    func = function()
                    card.ability.extra.xmult = (card.ability.extra.xmult) + 0.5
                    return true
                end,
                    extra = {
                    func = function()
                        
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_flash' })
                                    if joker_card then
                                    end
                                    G.GAME.joker_buffer = 0
                                    return true
                                end
                            }))
                        end
                        if created_joker then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
                        end
                        return true
                    end,
                    colour = G.C.BLUE
                }
            }
        end
        if context.other_joker  then
            if (function()
        return context.other_joker.config.center.key == "j_flash"
    end)() then
                return {
                    Xmult = card.ability.extra.xmult
                }
            end
        end
    end
}
SMODS.Joker{ --Green Cookie
    key = "greencookie",
    config = {
        extra = {
            mult = 17,
            multiplier = 1.03
        }
    },
    loc_txt = {
        ['name'] = 'Green Cookie',
        ['text'] = {
            [1] = '{C:red}+#1#{} Mult',
            [2] = 'Increase value by {C:red}#2#x{}',
            [3] = 'when a hand is played'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
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

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.multiplier}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                local mult_value = card.ability.extra.mult
                card.ability.extra.mult = (card.ability.extra.mult) * card.ability.extra.multiplier
                return {
                    mult = mult_value
                }
        end
    end
}
SMODS.Joker{ --Iciclez_
    key = "iciclez",
    config = {
        extra = {
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'Iciclez_',
        ['text'] = {
            [1] = 'Create {C:attention}an{} {C:blue}alt{}',
            [2] = 'when {C:attention}Blind{} is selected'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 6,
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
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.setting_blind or context.forcetrigger then
                return {
                    func = function()
            local created_joker = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_iciclezalt' })
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
SMODS.Joker{ --Iciclez_ alt
    key = "iciclezalt",
    config = {
		extra = {
			mult = 1.1,
			slots = 1
		}
    },
    loc_txt = {
        ['name'] = 'Iciclez_ alt',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{} Mult',
            [2] = '{C:dark_edition}+#2#{} Joker slot'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 7,
        y = 2
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
        return {vars = {card.ability.extra.mult, card.ability.extra.slots}}
    end,
	
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    Xmult = lenient_bignum(card.ability.extra.mult)
                }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_sholium_iciclezalt" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
	if e.config.ref_table.config.center.key == "j_sholium_iciclezalt" then
		e.config.colour = G.C.GREEN
		e.config.button = "use_card"
	else
		can_select_card_ref(e)
	end
end
SMODS.Joker{ --Issimo
    key = "issimo",
    config = {
        extra = {
            ante = 1,
            cash = 50
        }
    },
    loc_txt = {
        ['name'] = 'Issimo',
        ['text'] = {
            [1] = 'Earn {C:gold}$#2#{}, then{C:red} +#1#{} Ante when bought'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 8,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 1,
    rarity = 1,
    blueprint_compat = false,
    demicoloncompat = true,
    eternal_compat = false,
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
        return {vars = {card.ability.extra.ante, card.ability.extra.cash}}
    end,

    calculate = function(self, card, context)
        if context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers or context.forcetrigger then
                return {
                    dollars = card.ability.extra.cash,
                    extra = {
                        func = function()
                    local mod = card.ability.extra.ante
		ease_ante(mod)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + mod
				return true
			end,
		}))
                    return true
                end,
                            message = "Ante +" .. card.ability.extra.ante,
                        colour = G.C.FILTER
                        }
                }
        end
    end
}

SMODS.Joker{ --Literally Cryptid
    key = "literallycryptid",
    config = {
        extra = {
            repetitions = 2
        }
    },
    loc_txt = {
        ['name'] = 'Literally Cryptid',
        ['text'] = {
            [1] = 'if played hand is exactly {C:attention}1{} card,',
            [2] = 'create {C:attention}2{} copies of that card',
            [3] = 'and {C:red}self-destruct{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  and not context.blueprint then
            if to_big(#context.full_hand) == to_big(1) then
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
                end
                for i = 1, 2 do
                    local cards_to_copy = {}
                    local target_index = 1
                    if context.full_hand[target_index] then
                        table.insert(cards_to_copy, context.full_hand[target_index])
                    end
                    for i, source_card in ipairs(cards_to_copy) do
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local copied_card = copy_card(source_card, nil, nil, G.playing_card)
                        copied_card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, copied_card)
                        G.hand:emplace(copied_card)
                        copied_card.states.visible = nil
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                copied_card:start_materialize()
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end
}

SMODS.Joker{ --Literally The Soul
    key = "literallythesoul",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Literally The Soul',
        ['text'] = {
            [1] = 'Creates a {C:legendary}Legendary{} Joker',
            [2] = 'and {C:red}self-destruct{} when',
            [3] = '{C:attention}Boss Blind{} is defeated'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = false,
    demicoloncompat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss and not context.blueprint then
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
                    end
                    return true
                end,
                extra = {
                    func = function()
                        local created_joker = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local joker_card = SMODS.add_card({ set = 'Joker', rarity = 'Legendary' })
                                if joker_card then
                                end
                                return true
                            end
                        }))
                        if created_joker then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
                        end
                        return true
                    end,
                    colour = G.C.BLUE
                }
            }
        end
        if context.forcetrigger then
            return {
                func = function()
                    local created_joker = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local joker_card = SMODS.add_card({ set = 'Joker', rarity = 'Legendary' })
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

if Talisman then

SMODS.Joker{ --Pudding Egg
    key = "puddingegg",
    config = {
        extra = {
            slots = 1
        }
    },
    loc_txt = {
        ['name'] = 'Pudding Egg',
        ['text'] = {
            [1] = '{C:dark_edition}+#1#{} Joker slot',
            [2] = 'at end of round'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 1,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 30,
    rarity = "sholium_peculiar",
    blueprint_compat = false,
    demicoloncompat = true,
    eternal_compat = false,
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
        return {vars = {card.ability.extra.slots}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval or context.forcetrigger then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.slots).." Joker Slot", colour = G.C.DARK_EDITION})
                G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
                return true
            end
                }
        end
    end
}
SMODS.Joker{ --Simultaneous Divergence
    key = "simultaneousdivergence",
    config = {
        extra = {
            mult = 1,
            scale = 0.2
        }
    },
    loc_txt = {
        ['name'] = 'Simultaneous Divergence',
        ['text'] = {
            [1] = 'This Joker gains {X:legendary,C:white}^#2#{} Mult',
            [2] = 'if played hand has a',
            [3] = 'scoring {C:clubs}Club{} card',
            [4] = 'and a scoring card of',
            [5] = 'any other suit',
            [6] = '{C:inactive}(Currently{} {X:legendary,C:white}^#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 4,
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
        return {vars = {card.ability.extra.mult, card.ability.extra.scale}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    e_mult = card.ability.extra.mult
                }
        end
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if ((function()
    local suitCount = 0
    for i, c in ipairs(context.scoring_hand) do
        if c:is_suit("Clubs") then
            suitCount = suitCount + 1
        end
    end
    
    return suitCount >= 1
end)() and ((function()
    local suitCount = 0
    for i, c in ipairs(context.scoring_hand) do
        if c:is_suit("Hearts") then
            suitCount = suitCount + 1
        end
    end
    
    return suitCount >= 1
end)() or (function()
    local suitCount = 0
    for i, c in ipairs(context.scoring_hand) do
        if c:is_suit("Spades") then
            suitCount = suitCount + 1
        end
    end
    
    return suitCount >= 1
end)() or (function()
    local suitCount = 0
    for i, c in ipairs(context.scoring_hand) do
        if c:is_suit("Diamonds") then
            suitCount = suitCount + 1
        end
    end
    
    return suitCount >= 1
end)())) then
                return {
                    message = localize('k_upgrade_ex'),
                    func = function()
                    card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.scale
                    return true
                end
                }
            end
        end
        if context.forcetrigger then
            local mult_value = card.ability.extra.mult
            card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.scale
            return {
                emult = mult_value
            }
        end
    end
}
end
