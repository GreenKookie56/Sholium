SMODS.Joker{ --Carrier Flagship
    key = "carrierflagship",
    config = {
        extra = {
            chips = 3,
            odds = 3
        }
    },
    loc_txt = {
        ['name'] = 'Carrier Flagship',
        ['text'] = {
            [1] = 'Each played {C:clubs}Clubs{} has a',
            [2] = '{C:green}#2# in #3#{} chance to {X:blue,C:white}X#1#{} Chips',
            [3] = 'when scored',
            [4] = '{C:inactive}Let\'s go gambling!{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 1
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
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sholium_carrierflagship') 
        return {vars = {card.ability.extra.chips, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Clubs") then
                if SMODS.pseudorandom_probability(card, 'group_0_86561525', 1, card.ability.extra.odds, 'j_sholium_carrierflagship', false) then
              SMODS.calculate_effect({x_chips = card.ability.extra.chips}, card)
          end
            end
        end
        if context.forcetrigger then
            return {
                x_chips = card.ability.extra.chips
            }
        end
    end
}
