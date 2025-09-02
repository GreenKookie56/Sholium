SMODS.Joker{ --:squalch:
    key = "squalch",
    config = {
        extra = {
            chips = 4,
            squarechips = 16
        }
    },
    loc_txt = {
        ['name'] = ':squalch:',
        ['text'] = {
            [1] = '{C:blue}+#2#{} Chips',
            [2] = '{C:attention}Quadratically{} increases',
            [3] = 'if first played hand has',
            [4] = 'exactly {C:attention}4{} {C:spectral}scoring{} cards',
            [5] = '{C:inactive,s:0.7}(ex. +16, +25, +36, +49...){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, card.ability.extra.squarechips}}
    end,

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  then
            if (#context.scoring_hand == 4 and G.GAME.current_round.hands_played == 0) then
                local squarechips_value = card.ability.extra.squarechips
                return {
                    func = function()
                    card.ability.extra.chips = (card.ability.extra.chips) + 1
                    return true
                end,
                    extra = {
                        func = function()
                    card.ability.extra.squarechips = card.ability.extra.chips
                    return true
                end,
                        colour = G.C.BLUE,
                        extra = {
                            func = function()
                    card.ability.extra.squarechips = (card.ability.extra.squarechips) * card.ability.extra.chips
                    return true
                end,
                            message = "Upgrade!",
                            colour = G.C.MULT
                        }
                        }
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
                return {
                    chips = card.ability.extra.squarechips
                }
        end
        if context.forcetrigger then
            card.ability.extra.chips = (card.ability.extra.chips) + 1
            card.ability.extra.squarechips = (card.ability.extra.chips) * card.ability.extra.chips
            return {
                chips = card.ability.extra.squarechips
            }
        end
    end
}