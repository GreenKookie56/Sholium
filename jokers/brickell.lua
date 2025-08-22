SMODS.Joker{ --Brickell (v18.0)
    key = "brickell",
    config = {
        extra = {
            Mult = 1,
            increasement = 2
        }
    },
    loc_txt = {
        ['name'] = 'Brickell (v18.0)',
        ['text'] = {
            [1] = '{X:red,C:white}X#2#{} Mult every {C:attention}reroll{}',
            [2] = '{C:inactive}(Currently {}{X:red,C:white}X#1#{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 7,
        y = 2
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Mult, card.ability.extra.increasement}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.Mult
                }
        end
        if context.reroll_shop  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.Mult = (card.ability.extra.Mult) + card.ability.extra.increasement
                    return true
                end,
                    message = "Upgrade!"
                }
        end
    end
}