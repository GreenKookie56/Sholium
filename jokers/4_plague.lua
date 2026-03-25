SMODS.Joker{ --Bacteria
    key = "bacteria",
    config = {
        extra = {
            c = 10,
            m = 2,
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Bacteria',
        ['text'] = {
            [1] = '{C:blue}+#1#{} Chips',
            [2] = '{C:red}+#2#{} Mult',
            [3] = 'create a copy of this {C:attention}Joker{}',
            [4] = 'when {C:attention}Blind{} is selected',
            [5] = '{C:inactive}(Removes {}{C:dark_edition}Negative{} {C:inactive}from copy,{}',
            [6] = '{C:inactive}Must have room){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 3,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.c, card.ability.extra.m}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    chips = card.ability.extra.c,
                    extra = {
                        mult = card.ability.extra.m
                        }
                }
        end
        if context.setting_blind and not context.blueprint then
                return {
                    func = function()
                local target_joker = nil
                for i, joker in ipairs(G.jokers.cards) do
                    if joker.config.center.key == "j_sholium_bacteria" then
                        target_joker = joker
                        break
                    end
                end
                
                if target_joker and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local copied_joker = copy_card(target_joker, nil, nil, nil, target_joker.edition and target_joker.edition.negative)
                            
                            copied_joker:add_to_deck()
                            G.jokers:emplace(copied_joker)
                        G.GAME.joker_buffer = 0
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex'), colour = G.C.GREEN})
                end
                    return true
                end
                }
        end
    end
}

SMODS.Joker{ --Bioweapon
    key = "bioweapon",
    config = {
        extra = {
            minusmod = 2,
            timesmod = 0.4,
            minus = 0,
            times = 1
        }
    },
    loc_txt = {
        ['name'] = 'Bioweapon',
        ['text'] = {
            [1] = 'This Joker gains',
            [2] = '{C:red}-#1#{} Mult and {X:red,C:white}X#2#{} Mult',
            [3] = 'at the end of round',
            [4] = '{C:inactive}(Currently{} {C:red}#3#{}{C:inactive},{} {X:red,C:white}X#4#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 0
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.minusmod, card.ability.extra.timesmod, card.ability.extra.minus, card.ability.extra.times}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = card.ability.extra.minus,
                extra = {
                    Xmult = card.ability.extra.times
                }
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.minus = lenient_bignum(card.ability.extra.minus - card.ability.extra.minusmod)
                    return true
                end,
                message = localize('k_upgrade_ex'),
                extra = {
                    func = function()
                        card.ability.extra.times = lenient_bignum(card.ability.extra.times + card.ability.extra.timesmod)
                        return true
                    end,
                    colour = G.C.GREEN
                }
            }
        end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "times",
				scalar_value = "timesmod",
				message_key = "a_xmult",
				message_colour = G.C.RED,
			})
			return {
				Xmult = card.ability.extra.times,
			}
		end
    end
}
SMODS.Joker{ --Fungus
    key = "fungus",
    config = {
        extra = {
            mult = 0.5,
            hands = 5,
            round = 0
        }
    },
    loc_txt = {
        ['name'] = 'Fungus',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{} Mult',
            [2] = '{C:blue}+#2#{} hands when',
            [3] = '{C:attention}blind{} is selected'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 2
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
        return {vars = {card.ability.extra.mult, card.ability.extra.hands}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  and not context.blueprint then
                return {
                    Xmult = card.ability.extra.mult
                }
        end
        if context.setting_blind  then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.hands).." Hand", colour = G.C.GREEN})
                G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.hands
                return true
            end
                }
        end
        if context.forcetrigger then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.hands).." Hand", colour = G.C.GREEN})
                G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.hands
                return true
            end
                }
        end
    end
}

SMODS.Joker{ --Nano-virus
    key = "nanovirus",
    config = {
        extra = {
            discount_amount = '1'
        }
    },
    loc_txt = {
        ['name'] = 'Nano-virus',
        ['text'] = {
            [1] = 'Everything in shop',
            [2] = 'costs {C:money}$1{} less'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 3
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
    
    if next(SMODS.find_card("j_sholium_nanovirus")) then
        if (self.ability.set == 'Joker' or self.ability.set == 'Tarot' or self.ability.set == 'Planet' or self.ability.set == 'Spectral' or self.ability.set == 'Enhanced' or self.ability.set == 'Booster' or self.ability.set == 'Voucher') then
            self.cost = math.max(0, self.cost - (1))
        end
    end
    
    self.sell_cost = math.max(1, math.floor(self.cost / 2)) + (self.ability.extra_value or 0)
    self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
end

SMODS.Joker{ --Parasite
    key = "parasite",
    config = {
        extra = {
            mult = 0,
            mod = 5
        }
    },
    loc_txt = {
        ['name'] = 'Parasite',
        ['text'] = {
            [1] = 'This Joker gains {C:red}+#2#{} Mult',
            [2] = 'for the {C:attention}last{} played hand',
            [3] = '{C:inactive}(Currently{} {C:red}+#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 3
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.mod}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    mult = card.ability.extra.mult
                }
        end
        if context.before and context.cardarea == G.jokers and not context.blueprint then
            if G.GAME.current_round.hands_left == 0 then
                return {
                    func = function()
                    card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mod
                    return true
                end,
                    message = localize('k_upgrade_ex')
                }
            end
        end
        if context.forcetrigger then
            local mult_value = card.ability.extra.mult
            card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mod
            return {
                mult = mult_value
            }
        end
    end
}
SMODS.Joker{ --Prion
    key = "prion",
    config = {
        extra = {
            odds = 3,
            ante_value = 1
        }
    },
    loc_txt = {
        ['name'] = 'Prion',
        ['text'] = {
            [1] = '{C:green}#1# in #2#{} chance to {C:attention}-1{} {C:dark_edition}Ante{}',
            [2] = 'when {C:attention}Boss Blind{} is defeated'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 4
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
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sholium_prion') 
        return {vars = {new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_ebc71fee', 1, card.ability.extra.odds, 'j_sholium_prion', false) then
              SMODS.calculate_effect({func = function()
                    local mod = -card.ability.extra.ante_value
		ease_ante(mod)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + mod
				return true
			end,
		}))
                    return true
                end}, card)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Ante -" .. card.ability.extra.ante_value, colour = G.C.FILTER})
          end
            end
        end
        if context.forcetrigger then
              SMODS.calculate_effect({func = function()
                    local mod = -card.ability.extra.ante_value
		ease_ante(mod)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + mod
				return true
			end,
		}))
                    return true
                end}, card)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Ante -" .. card.ability.extra.ante_value, colour = G.C.FILTER})
        end
    end
}
SMODS.Joker{ --Virus
    key = "virus",
    config = {
        extra = {
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Virus',
        ['text'] = {
            [1] = 'Create a random {C:rare}Rare{} Joker',
            [2] = 'at the end of round',
            [3] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 4
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'jud' and args.source ~= 'rif' and args.source ~= 'rta' and args.source ~= 'sou' and args.source ~= 'uta' and args.source ~= 'wra' 
          or args.source == 'sho' or args.source == 'buf'
          )
          and true
      end,

    set_ability = function(self, card, initial)
        card:set_eternal(true)
        card:add_sticker('rental', true)
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
                return {
                    func = function()
            local created_joker = false
    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
        created_joker = true
        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', rarity = 'Rare' })
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
        end
                }
        end
       if context.forcetrigger then
              SMODS.calculate_effect({func = function()
            local created_joker = false
    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
        created_joker = true
        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', rarity = 'Rare' })
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
        end}, card)
          end
    end
}
if Talisman then

SMODS.Joker{ --Neurax worm
    key = "neuraxworm",
    config = {
        extra = {
            mult = 1.1,
            odds = 2
        }
    },
    loc_txt = {
        ['name'] = 'Neurax worm',
        ['text'] = {
            [1] = 'Each card held in hand has a',
            [2] = '{C:green}#2# in #3#{} chance to {X:legendary,C:white}^#1#{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
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
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    soul_pos = {
        x = 3,
        y = 3
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
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sholium_neuraxworm') 
        return {vars = {card.ability.extra.mult, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_ea22710b', 1, card.ability.extra.odds, 'j_sholium_neuraxworm', false) then
              SMODS.calculate_effect({e_mult = card.ability.extra.mult}, card)
          end
            end
        end
        if context.forcetrigger then
            return {
                e_mult = card.ability.extra.mult
            }
        end
    end
}

end