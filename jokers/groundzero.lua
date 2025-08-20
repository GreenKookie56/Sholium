SMODS.Joker{ --Ground Zero (pre-nerf)
    key = "groundzero",
    config = {
        extra = {
            mult = 700
        }
    },
    loc_txt = {
        ['name'] = 'Ground Zero (pre-nerf)',
        ['text'] = {
            [1] = '{C:red}+700{} Mult for the',
            [2] = 'first hand of the round',
            [3] = '{s:0.8,C:inactive}ok this is definitely NOT bloonlatro{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 4
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
        if context.cardarea == G.jokers and context.joker_main  then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}