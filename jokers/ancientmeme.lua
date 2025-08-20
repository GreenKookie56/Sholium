SMODS.Joker{ --Ancient meme
    key = "ancientmeme",
    config = {
        extra = {
            dollars = 939
        }
    },
    loc_txt = {
        ['name'] = 'Ancient meme',
        ['text'] = {
            [1] = '{X:money,C:edition}=$939{} when',
            [2] = 'shop is rerolled'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 1
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.reroll_shop  and not context.blueprint then
                return {
                    func = function()
                    local target_amount = card.ability.extra.dollars
                    local current_amount = G.GAME.dollars
                    local difference = target_amount - current_amount
                    ease_dollars(difference)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Set to $"..tostring(card.ability.extra.dollars), colour = G.C.MONEY})
                    return true
                end
                }
        end
    end
}