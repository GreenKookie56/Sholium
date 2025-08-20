SMODS.Joker{ --Horseboard
    key = "horseboard",
    config = {
        extra = {
            emult = 7
        }
    },
    loc_txt = {
        ['name'] = 'Horseboard',
        ['text'] = {
            [1] = '{X:legendary,C:white}^1{} Mult for every {C:attention}horse react{} in',
            [2] = '{C:dark_edition}Bloonlatro horseboard{}',
            [3] = '(in sholatro-ideas, Bloonlatro server)',
            [4] = '{C:inactive}(Currently{} {X:legendary,C:white}^7{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 4
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    soul_pos = {
        x = 0,
        y = 5
    },

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    e_mult = card.ability.extra.emult
                }
        end
    end
}