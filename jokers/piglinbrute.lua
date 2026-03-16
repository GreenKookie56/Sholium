
SMODS.Joker{ --Piglin Brute
    key = "piglinbrute",
    config = {
        extra = {
            mult = 1,
            scale = 4
        }
    },
    loc_txt = {
        ['name'] = 'Piglin Brute',
        ['text'] = {
            [1] = 'This Joker gains {X:red,C:white}X#2#{} Mult',
            [2] = 'if played hand contains',
            [3] = 'a {C:attention}Straight Flush{}',
            [4] = '{C:inactive}(Currently {}{X:red,C:white}X#1#{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mult, card.ability.extra.scale}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if next(context.poker_hands["Straight Flush"]) then
                return {
                    func = function()
                        card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.scale
                        return true
                    end,
                    message = "Upgrade!"
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
            return {
                Xmult = card.ability.extra.mult
            }
        end
        if context.forcetrigger then
            return {
                func = function()
                    card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.scale
                    Xmult = card.ability.extra.mult
                    return true
                end
            }
        end
    end
}
