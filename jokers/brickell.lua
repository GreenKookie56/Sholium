SMODS.Joker{ --Brickell
    key = "brickell",
    config = {
        extra = {
            Mult = 1,
            increasement = 1
        }
    },
    loc_txt = {
        ['name'] = 'Brickell',
        ['text'] = {
            [1] = '{X:red,C:white}X#2#{} Mult every {C:attention}reroll{}',
            [2] = 'resets at end of round',
            [3] = '{C:inactive}(Currently {}{X:red,C:white}X#1#{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Mult, card.ability.extra.increasement}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
                return {
                    Xmult = card.ability.extra.Mult
                }
        end
        if context.reroll_shop  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.Mult = (card.ability.extra.Mult) + card.ability.extra.increasement
                    return true
                end,
                    message = "Upgrade!"
                }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.Mult = 1
                    return true
                end
                }
        end
        if context.forcetrigger then
            local mult_value = card.ability.extra.Mult
            card.ability.extra.Mult = (card.ability.extra.Mult) + card.ability.extra.increasement
            return {
                Xmult = mult_value
            }
        end
    end
}
