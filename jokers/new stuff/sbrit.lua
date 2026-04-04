
SMODS.Joker{ --Super Brittle (v51)
    key = "sbrit",
    config = {
        extra = {
            chips = 150
        }
    },
    loc_txt = {
        ['name'] = 'Super Brittle (v51)',
        ['text'] = {
            [1] = 'Each held in hand {C:attention}5s{}',
            [2] = 'give {C:blue}+#1#{} Chips'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chips}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round  then
            if context.other_card:get_id() == 5 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
        if context.forcetrigger then
            chips = card.ability.extra.chips
        end
    end
}