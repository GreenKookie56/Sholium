SMODS.Joker{ --Bluepint
    key = "bluepint",
    config = {
        extra = {
            mult = 5
        }
    },
    loc_txt = {
        ['name'] = 'Bluepint',
        ['text'] = {
            [1] = 'Copies ability of',
            [2] = '{C:attention}Joker{} to the front',
            [3] = '{s:0.8,X:green,C:white} compatible {}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 2
    },
    cost = 10,
    rarity = "sholium__rare",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    mult = card.ability.extra.mult
                }
        end
    end
}