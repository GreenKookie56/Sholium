SMODS.Joker{ --Pop and Awe
    key = "popandawe",
    config = {
    },
    loc_txt = {
        ['name'] = 'Pop and Awe',
        ['text'] = {
            [1] = '{C:blue}-8{} Chips',
            [2] = '{X:blue,C:white}X3{} Chips'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 8,
        y = 3
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
                    chips = -8,
                    extra = {
                        x_chips = 3,
                        colour = G.C.DARK_EDITION
                        }
                }
        end
    end
}
