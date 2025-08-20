SMODS.Joker{ --Sheppi
    key = "sheppi",
    config = {
        extra = {
            chips = 1,
            scale = 0.02
        }
    },
    loc_txt = {
        ['name'] = 'Sheppi',
        ['text'] = {
            [1] = 'When a {C:hearts}Heart{} is played and scored,',
            [2] = '{X:blue,C:white}X#1#{} Chips and',
            [3] = 'increase {X:blue,C:white}XChips{} value by {X:blue,C:white}#2#{}',
            [4] = '{C:inactive}Art & Design by Ic1clez_{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 7
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
        return {vars = {card.ability.extra.chips, card.ability.extra.scale}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Hearts") then
                local chips_value = card.ability.extra.chips
                card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.scale
                return {
                    x_chips = chips_value,
                    extra = {
                        message = "Upgrade!",
                        colour = G.C.GREEN
                        }
                }
            end
        end
    end
}