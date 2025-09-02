SMODS.Joker{ --Green Cookie
    key = "greencookie",
    config = {
        extra = {
            mult = 17,
            multiplier = 1.05
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