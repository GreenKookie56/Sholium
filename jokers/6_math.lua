SMODS.Joker{ --Boundary
    key = "boundary",
    config = {
    },
    loc_txt = {
        ['name'] = 'Boundary',
        ['text'] = {
            [1] = 'lim {C:attention}n{} -> {X:dark_edition,C:white}+infinity{}',
            [2] = '{X:red,C:white}X1.444667861^^n{} Mult',
            [3] = '{C:inactive,s:0.6}Explanation: e^e^-1 has exactly {}',
            [4] = '{C:inactive,s:0.6}1 fixed point for f(x)=a^x, which is e{}',
            [5] = '{C:inactive,s:0.6}That means (e^e^-1)^^inf, or {}',
            [6] = '{C:inactive,s:0.6}(e^e^-1)^(e^e^-1)^... stacking infinite times,{}',
            [7] = '{C:inactive,s:0.6}does not scale past the fix point{}',
            [8] = '{C:inactive,s:0.6}1.444667861 is an approximation of e^e^-1{}',
            [9] = '{C:inactive,s:0.6}which has 2 fixed points for f(x)=a^x, {}',
            [10] = '{C:inactive,s:0.6}which stacks to around 2.718{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 9,
        y = 0
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
                    Xmult = 2.718
                }
        end
    end
}
SMODS.Joker{ --Normal distribution
    key = "normaldistribution",
    config = {
        extra = {
            Xmult7 = 0.68,
            Xmult68 = 0.13,
            Xmult59 = 0.03
        }
    },
    loc_txt = {
        ['name'] = 'Normal distribution',
        ['text'] = {
			[1] = 'Starts from {X:red,C:white}X1{} Mult,',
            [2] = 'When a hand is played,',
            [3] = 'gives extra {X:red,C:white}X#1#{} Mult for each {C:attention}7{},',
            [4] = '{X:red,C:white}X#2#{} Mult for each {C:attention}6 or 8{},',
            [5] = 'and {X:red,C:white}X#3#{} Mult for each {C:attention}5 or 9{}',
            [6] = 'contained in played hand',
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult7, card.ability.extra.Xmult68, card.ability.extra.Xmult59 } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local total = 1
            for k, v in ipairs(context.full_hand) do
                if v:get_id() == 7 then
                    total = total + card.ability.extra.Xmult7
                elseif v:get_id() == 6 or v:get_id() == 8 then
                    total = total + card.ability.extra.Xmult68
                elseif v:get_id() == 5 or v:get_id() == 9 then
                    total = total + card.ability.extra.Xmult59
                end
            end
            if total > 1 then
                return {
                    x_mult = total
                }
            end
		end
    end
}

SMODS.Joker{ --Rotation Matrix
    key = "rotationmatrix",
    config = {
        extra = {
            mult = 1.0471975512,
            immutable = {
                current = 1
            }
        }
    },
    loc_txt = {
        ['name'] = 'Rotation Matrix',
        ['text'] = {
            [1] = 'If played hand has exactly',
            [2] = '{C:attention}#1#{} scoring card(s),',
            [3] = 'this Joker gains {C:red}+2pi/3{} Mult',
            [4] = 'and rotates requirement',
            [5] = 'to the next option {C:inactive}(1 -> 3 -> 5){}',
            [6] = '{C:inactive}(Currently approximately{} {C:red}+#2#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 5
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
        
        return {vars = {card.ability.extra.immutable.current, card.ability.extra.mult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            if (to_big(#context.scoring_hand) == to_big(1) and to_big((card.ability.extra.immutable.current or 0)) == to_big(1)) then -- need to do this since retriggers exist
                return {
                    func = function ()
                        card.ability.extra.immutable.current = 3
                        card.ability.extra.mult = (card.ability.extra.mult) + 2.09439510239
                    end,
                    message = localize('k_upgrade_ex'),
                }
            elseif (to_big(#context.scoring_hand) == to_big(3) and to_big((card.ability.extra.immutable.current or 0)) == to_big(3)) then
                return {
                    func = function ()
                        card.ability.extra.immutable.current = 5
                        card.ability.extra.mult = (card.ability.extra.mult) + 2.09439510239
                    end,
                    message = localize('k_upgrade_ex'),
                }
            elseif (to_big(#context.scoring_hand) == to_big(5) and to_big((card.ability.extra.immutable.current or 0)) == to_big(5)) then
                return {
                    func = function ()
                        card.ability.extra.immutable.current = 1
                        card.ability.extra.mult = (card.ability.extra.mult) + 2.09439510239
                    end,
                    message = localize('k_upgrade_ex'),
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.forcetrigger then
            return {
                func = function ()
                    card.ability.extra.mult = (card.ability.extra.mult) + 2.09439510239
                end,
                mult = card.ability.extra.mult
            }
        end
    end
}

if Talisman then
SMODS.Joker{ --Derivative
    key = "derivative",
    config = {
        extra = {
            emult = 0.75,
            xmult = 4
        }
    },
    loc_txt = {
        ['name'] = 'Derivative',
        ['text'] = {
            [1] = '{X:legendary,C:white}^#1#{} Mult',
            [2] = '{X:red,C:white}X#2#{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 5
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
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.emult, card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                e_mult = card.ability.extra.emult,
                extra = {
                    Xmult = card.ability.extra.xmult
                }
            }
        end
    end
}
end