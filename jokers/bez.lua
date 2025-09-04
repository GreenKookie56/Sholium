SMODS.Joker{ --Bloon Exclusion Zone (v38+)
    key = "bez",
    config = {
        extra = {
            scored = 0,
            pb_mult_7e6bb471 = 6,
            perma_mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Bloon Exclusion Zone (v38+)',
        ['text'] = {
            [1] = 'Every scored {C:spades}Spades{}',
            [2] = 'permanently gains {C:red}+6{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Spades") then
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.pb_mult_7e6bb471
                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.MULT }, card = card
                }
            end
        end
    end
}