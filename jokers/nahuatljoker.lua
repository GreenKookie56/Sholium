
SMODS.Joker{ --Nahuatl Joker
    key = "nahuatljoker",
    config = {
        extra = {
            mod = 1,
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Nahuatl Joker',
        ['text'] = {
            [1] = 'This Joker gains {C:mult}+#1#{} Mult and reduces',
            [2] = 'rank of each scoring card by {C:attention}1{}',
            [3] = 'if played hand is exactly {C:attention}3{} cards',
            [4] = '{C:inactive}(Currently{} {C:red}+#2#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mod, card.ability.extra.mult}}
    end,
    
    calculate = function(self, card, context)
       if context.individual and context.cardarea == G.play and to_big(#context.full_hand) == to_big(3) then
            local scored_card = context.other_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    assert(SMODS.modify_rank(scored_card, -1))
                    return true
                end
            }))
            card.ability.extra.mult = lenient_bignum(card.ability.extra.mult + card.ability.extra.mod)
        end
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            return {
                mult = lenient_bignum(card.ability.extra.mult)
            }
        end
    end
}
