SMODS.Joker{ --Boss Farming Guide
    key = "bossfarmingguide",
    config = {
        extra = {
            eor = 2,
            thenumerator = 1,
            money÷5 = 0
        }
    },
    loc_txt = {
        ['name'] = 'Boss Farming Guide',
        ['text'] = {
            [1] = 'Earn {C:gold}$#1#{} at the end of round',
            [2] = 'Payout increases by {C:gold}$2{} for every {C:gold}$5{}',
            [3] = 'you have at the end of round'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 4,
        y = 2
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.eor}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.eor = (card.ability.extra.eor) + math.floor(lenient_bignum(G.GAME.dollars / 5))
                    return true
                end,
                    message = "Farming!",
                    extra = {
                        dollars = card.ability.extra.eor,
                        colour = G.C.MONEY
                        }
                }
        end
    end
}
