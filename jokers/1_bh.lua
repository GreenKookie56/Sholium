SMODS.Joker{ --Adasaurus
    key = "adasaurus",
    config = {
        extra = {
            mult = 6
        }
    },
    loc_txt = {
        ['name'] = 'Adasaurus (v36-53)',
        ['text'] = {
            [1] = 'Each played cards',
            [2] = 'give {C:red}+#1#{} Mult when scored'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 2,
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
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play or context.forcetrigger then
                return {
                    mult = card.ability.extra.mult
                }
        end
    end
}

SMODS.Joker{ --Barracuda
    key = "barracuda",
    config = {
        extra = {
            repetitions = 1
        }
    },
    loc_txt = {
        ['name'] = 'Barracuda',
        ['text'] = {
            [1] = 'Retrigger each played',
            [2] = '{C:attention}6, 7, 8, 9 or 10{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 4,
        y = 0
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
            if (context.other_card:get_id() == 6 or context.other_card:get_id() == 7 or context.other_card:get_id() == 8 or context.other_card:get_id() == 9 or context.other_card:get_id() == 10) then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = "Again!"
                }
            end
        end
    end
}

SMODS.Joker{ --Giganotosaurus
    key = "giganotosaurus",
    config = {
        extra = {
            hands = 2,
            Xmult = 6,
            round = 0
        }
    },
    loc_txt = {
        ['name'] = 'Giganotosaurus',
        ['text'] = {
            [1] = '{X:red,C:white}X#2#{} Mult',
            [2] = '{C:blue}-#1#{} hands',
            [3] = 'when a hand is played'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.hands, card.ability.extra.Xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(card.ability.extra.hands).." Hand", colour = G.C.RED})
                G.GAME.current_round.hands_left = G.GAME.current_round.hands_left - card.ability.extra.hands
                return true
            end
                }
        end
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    Xmult = card.ability.extra.Xmult
                }
        end
    end
}

SMODS.Joker{ --Megalodon
    key = "megalodon",
    config = {
        extra = {
            mult = 1,
            chips = 1,
            scale = 1
        }
    },
    loc_txt = {
        ['name'] = 'Megalodon',
        ['text'] = {
            [1] = 'When a {C:red}Mult Card{} / {C:blue}Bonus Card{}',
            [2] = 'is scored, this Joker gains',
            [3] = '{X:red,C:white}X#3#{} Mult / {X:blue,C:white}X#3#{} Chips respectively',
            [4] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{}{C:inactive} Mult, {}{X:blue,C:white}X#2#{}{C:inactive} Chips){}',
            [5] = '{C:inactive}Art by 1.2m^2 Fungus Room{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 3
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
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' 
            or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.scale}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if SMODS.get_enhancements(context.other_card)["m_mult"] == true then
                card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.scale
                return {
                    message = localize('k_upgrade_ex')
                }
            elseif SMODS.get_enhancements(context.other_card)["m_bonus"] == true then
                card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.scale
                return {
                    message = localize('k_upgrade_ex')
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.mult,
                x_chips = card.ability.extra.chips,
            }
        end
        if context.forcetrigger then
            return {
                Xmult = card.ability.extra.mult,
                x_chips = card.ability.extra.chips,
            }
        end
    end
}
SMODS.Joker{ --Orca (v36.0-36.1)
    key = "orca",
    config = {
        extra = {
            patch = 1,
            mult = 18.75,
            dead = 0
        }
    },
    loc_txt = {
        ['name'] = 'Orca (v36.0-36.1)',
        ['text'] = {
            [1] = '{X:red,C:white}X#2#{} Mult',
            [2] = 'sets to {X:red,C:white}X#1#{} Mult when',
            [3] = '{C:attention}Boss Blind{} is defeated'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 4,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.patch, card.ability.extra.mult}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.mult
                }
        end
        if (context.end_of_round and context.main_eval and G.GAME.blind.boss  and not context.blueprint) or context.forcetrigger then
            if (card.ability.extra.dead or 0) == 0 then
                return {
                    func = function()
                    card.ability.extra.dead = 1
                    return true
                end,
                    extra = {
                        func = function()
                    card.ability.extra.mult = card.ability.extra.patch
                    return true
                end,
                            message = "Patched!",
                        colour = G.C.BLUE
                        }
                }
            end
        end
    end
}
SMODS.Joker{ --Pouakai (v36-38)
    key = "pouakai",
    config = {
        extra = {
            handsizemod = 1,
            basehandsize = 8
        }
    },
    loc_txt = {
        ['name'] = 'Pouakai (v36-38)',
        ['text'] = {
            [1] = '{X:attention,C:white}=#2#{} hand size',
            [2] = 'when {C:attention}Blind{} is selected',
            [3] = '{C:attention}+#1#{} hand size',
            [4] = 'when a {C:attention}hand{} is played'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 9,
        y = 3
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
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'jud' and args.source ~= 'rif' and args.source ~= 'sou' and args.source ~= 'uta' and args.source ~= 'wra' 
          or args.source == 'sho' or args.source == 'buf' or args.source == 'rta'
          )
          and true
      end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.handsizemod, card.ability.extra.basehandsize}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.handsizemod).." Hand Size", colour = G.C.BLUE})
                G.hand:change_size(card.ability.extra.handsizemod)
                return true
            end
                }
        end
        if context.setting_blind  and not context.blueprint then
                return {
                    func = function()
                local current_hand_size = G.hand.config.card_limit
                local target_hand_size = card.ability.extra.basehandsize
                local difference = target_hand_size - current_hand_size
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Hand Size set to "..tostring(card.ability.extra.basehandsize), colour = G.C.BLUE})
                G.hand:change_size(difference)
                return true
            end
                }
        end
        if context.selling_self  and not context.blueprint then
                return {
                    func = function()
                local current_hand_size = G.hand.config.card_limit
                local target_hand_size = card.ability.extra.basehandsize
                local difference = target_hand_size - current_hand_size
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Hand Size set to "..tostring(card.ability.extra.basehandsize), colour = G.C.BLUE})
                G.hand:change_size(difference)
                return true
            end
                }
        end
    end
}
SMODS.Joker{ --Stupid Owl Stall
    key = "stupidowlstall",
    config = {
        extra = {
            hands = 1,
            chips = 0,
            odds = 2,
            round = 0
        }
    },
    loc_txt = {
        ['name'] = 'Stupid Owl Stall',
        ['text'] = {
            [1] = 'When a hand is played,',
            [2] = '{C:green}#4# in #5#{} chance',
            [3] = 'to {C:blue}+#1#{} hand and {X:blue,C:white}X#2#{} Chips'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 4
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
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sholium_stupidowlstall') 
        return {vars = {card.ability.extra.hands, card.ability.extra.chips, card.ability.extra.round, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_e9967624', 1, card.ability.extra.odds, 'j_sholium_stupidowlstall', false) then
              SMODS.calculate_effect({x_chips = card.ability.extra.chips}, card)
                        SMODS.calculate_effect({func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.hands).." Hand", colour = G.C.GREEN})
                G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.hands
                return true
            end}, card)
          end
            end
        end
    end
}
