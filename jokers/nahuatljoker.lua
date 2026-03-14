
SMODS.Joker{ --Nahuatl Joker
    key = "nahuatljoker",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Nahuatl Joker',
        ['text'] = {
            [1] = '{C:attention}-1{} rank of each {C:attention}scored{} card',
            [2] = 'if played hand is exactly {C:attention}3{} cards'
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
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
       if context.individual and context.cardarea == G.play and to_big(#context.full_hand) == to_big(3) then
            local scored_card = context.other_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    assert(SMODS.modify_rank(scored_card, -1))
                    return true
                end
            }))
        end
    end
}
