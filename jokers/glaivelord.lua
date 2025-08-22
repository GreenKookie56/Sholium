SMODS.Joker{ --Glaive Lord (v44)
    key = "glaivelord",
    config = {
        extra = {
            chips = 0,
            chipsmod = 8
        }
    },
    loc_txt = {
        ['name'] = 'Glaive Lord (v44)',
        ['text'] = {
            [1] = 'This Joker gains {C:blue}+#2#{} Chips',
            [2] = 'for each scored card',
            [3] = '{C:inactive}(Currently {}{C:blue}+#1#{}{C:inactive} Chips){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 4
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    soul_pos = {
        x = 6,
        y = 4
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, card.ability.extra.chipsmod}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
                card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.chipsmod
                return {
                    message = "Upgrade!"
                }
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.chips
                }
        end
    end
}