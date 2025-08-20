SMODS.Joker{ --Pudding Egg
    key = "puddingegg",
    config = {
        extra = {
            addmult = 100,
            addmoney = 10,
            timesmult = 10,
            powmult = 3,
            joker_slots = 3
        }
    },
    loc_txt = {
        ['name'] = 'Pudding Egg',
        ['text'] = {
            [1] = '{C:dark_edition}+3{} Joker slots at end of round {C:inactive}(immutable){}',
            [2] = 'Each held Joker gives effect',
            [3] = 'based on its rarity',
            [4] = '({C:red}+#1#{} Mult, {C:money}+$#2#{}, {X:red,C:white}X#3#{} Mult, {X:legendary,C:white}^#4#{} Mult, {C:dark_edition}2x{} value',
            [5] = 'for Common, Uncommon, Rare, Legendary, Peculiar)'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 8,
        y = 6
    },
    cost = 30,
    rarity = "sholium_peculiar",
    blueprint_compat = false,
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
        return {vars = {card.ability.extra.addmult, card.ability.extra.addmoney, card.ability.extra.timesmult, card.ability.extra.powmult}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.joker_slots).." Joker Slot", colour = G.C.DARK_EDITION})
                G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots
                return true
            end
                }
        end
        if context.other_joker  then
            if (function()
    return context.other_joker.config.center.rarity == 1
end)() then
                return {
                    mult = card.ability.extra.addmult
                }
            elseif (function()
    return context.other_joker.config.center.rarity == 2
end)() then
                return {
                    dollars = card.ability.extra.addmoney
                }
            elseif (function()
    return context.other_joker.config.center.rarity == 3
end)() then
                return {
                    Xmult = card.ability.extra.timesmult
                }
            elseif (function()
    return context.other_joker.config.center.rarity == 4
end)() then
                return {
                    e_mult = card.ability.extra.powmult
                }
            elseif (function()
    return context.other_joker.config.center.rarity == "sholium_peculiar"
end)() then
                return {
                    func = function()
                    card.ability.extra.addmult = (card.ability.extra.addmult) * 2
                    return true
                end,
                    extra = {
                        func = function()
                    card.ability.extra.addmoney = (card.ability.extra.addmoney) * 2
                    return true
                end,
                        colour = G.C.MULT,
                        extra = {
                            func = function()
                    card.ability.extra.timesmult = (card.ability.extra.timesmult) * 2
                    return true
                end,
                            colour = G.C.MULT,
                        extra = {
                            func = function()
                    card.ability.extra.powmult = (card.ability.extra.powmult) * 2
                    return true
                end,
                            colour = G.C.MULT
                        }
                        }
                        }
                }
            end
        end
    end
}