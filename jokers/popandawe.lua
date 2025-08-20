SMODS.Joker{ --Pop and Awe (v39)
    key = "popandawe",
    config = {
        extra = {
            chips = -8,
            xchips = 4
        }
    },
    loc_txt = {
        ['name'] = 'Pop and Awe (v39)',
        ['text'] = {
            [1] = '{C:blue}-8{} Chips',
            [2] = '{X:blue,C:white}X4{} Chips'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 6
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
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.chips,
                    extra = {
                        x_chips = card.ability.extra.xchips,
                        colour = G.C.DARK_EDITION
                        }
                }
        end
    end
}