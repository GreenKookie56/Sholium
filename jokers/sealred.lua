SMODS.Joker{ --Red Seal
    key = "sealred",
    config = {
        extra = {
            repetitions = 1
        }
    },
    loc_txt = {
        ['name'] = 'Red Seal',
        ['text'] = {
            [1] = '{C:attention}-1{} Hand size',
            [2] = 'Retrigger all played cards'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = localize('k_again_ex')
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
