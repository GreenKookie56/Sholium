SMODS.Joker{ --Gold Seal
    key = "sealgold",
    config = {
        extra = {
            dollars = 3
        }
    },
    loc_txt = {
        ['name'] = 'Gold Seal',
        ['text'] = {
            [1] = '{C:attention}-1{} Hand size',
            [2] = 'Earn {C:gold}$3{} when a hand is played'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
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
                    dollars = card.ability.extra.dollars
                }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(-1)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(1)
    end
}
