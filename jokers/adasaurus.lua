SMODS.Joker{ --Adasaurus
    key = "adasaurus",
    config = {
        extra = {
            mult = 6
        }
    },
    loc_txt = {
        ['name'] = 'Adasaurus',
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
