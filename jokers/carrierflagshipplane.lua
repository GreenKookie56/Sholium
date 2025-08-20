SMODS.Joker{ --Carrier Flagship plane
    key = "carrierflagshipplane",
    config = {
        extra = {
            chips = 2,
            odds = 2
        }
    },
    loc_txt = {
        ['name'] = 'Carrier Flagship plane',
        ['text'] = {
            [1] = 'Each played {C:clubs}Clubs{} has a',
            [2] = '{C:green}#2# in #3#{} chance to {X:blue,C:white}X#1#{} Chips',
            [3] = 'when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 2
    },
    cost = 1,
    rarity = "sholium_subtower",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sholium_carrierflagshipplane') 
        return {vars = {card.ability.extra.chips, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Clubs") then
                if SMODS.pseudorandom_probability(card, 'group_0_86561525', 1, card.ability.extra.odds, 'j_sholium_carrierflagshipplane') then
                      SMODS.calculate_effect({x_chips = card.ability.extra.chips}, card)
                  end
            end
        end
    end
}