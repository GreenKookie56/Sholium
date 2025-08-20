SMODS.Joker{ --Shiniest award
    key = "shiniestaward",
    config = {
        extra = {
            rounds = 0,
            mult = 2000000
        }
    },
    loc_txt = {
        ['name'] = 'Shiniest award',
        ['text'] = {
            [1] = '{C:red}+2,000,000{} Mult',
            [2] = 'only after playing {C:attention}38{} hands',
            [3] = '{C:inactive}#1#/38{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 7
    },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.rounds}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (card.ability.extra.rounds or 0) >= 38 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
        if context.after and context.cardarea == G.jokers  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.rounds = (card.ability.extra.rounds) + 1
                    return true
                end,
                    message = "Update!"
                }
        end
    end
}