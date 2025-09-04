SMODS.Joker{ --Rosalia (v43)
    key = "rosalia",
    config = {
        extra = {
            chips = 43
        }
    },
    loc_txt = {
        ['name'] = 'Rosalia (v43)',
        ['text'] = {
            [1] = '{C:blue}+43{} Chips'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 3,
        y = 4
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

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    chips = card.ability.extra.chips
                }
        end
    end
}