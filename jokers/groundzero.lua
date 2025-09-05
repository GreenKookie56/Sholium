SMODS.Joker{ --Ground Zero (v18-29)
    key = "groundzero",
    config = {
        extra = {
            chips = 700
        }
    },
    loc_txt = {
        ['name'] = 'Ground Zero (v18-29)',
        ['text'] = {
            [1] = '{C:blue}+700{} Chips for the',
            [2] = 'first hand of the round',
            [3] = '{s:0.8,C:inactive}this looks familiar{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
        if context.forcetrigger then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}