
SMODS.Joker{ --Copper Joker
    key = "copperjoker",
    config = {
        extra = {
            multiplier = 0.25,
            base = 1
        }
    },
    loc_txt = {
        ['name'] = 'Copper Joker',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{} Mult for each',
            [2] = 'leftover hands',
            [3] = '{C:inactive}(Currently{} {X:red,C:white}X#2#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 8
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
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.multiplier, card.ability.extra.base + ((G.GAME.current_round.hands_left or 0)) * card.ability.extra.multiplier}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                Xmult = lenient_bignum(card.ability.extra.base + (G.GAME.current_round.hands_left) * card.ability.extra.multiplier)
            }
        end
    end
}