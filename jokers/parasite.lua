SMODS.Joker{ --Parasite
    key = "parasite",
    config = {
        extra = {
            mult = 0,
            mod = 6
        }
    },
    loc_txt = {
        ['name'] = 'Parasite',
        ['text'] = {
            [1] = 'This Joker gains {C:red}+#2#{} Mult',
            [2] = 'for the {C:attention}last{} played hand',
            [3] = '{C:inactive}(Currently{} {C:red}+#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 3
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.mod}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    mult = card.ability.extra.mult
                }
        end
        if context.before and context.cardarea == G.jokers and not context.blueprint then
            if G.GAME.current_round.hands_left == 0 then
                return {
                    func = function()
                    card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mod
                    return true
                end,
                    message = "Upgrade!"
                }
            end
        end
        if context.forcetrigger then
            local mult_value = card.ability.extra.mult
            card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mod
            return {
                mult = mult_value
            }
        end
    end
}