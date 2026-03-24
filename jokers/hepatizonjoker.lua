
SMODS.Joker{ --Hepatizon Joker
    key = "hepatizonjoker",
    config = {
        extra = {
            rep = 0,
            current = 0
        }
    },
    loc_txt = {
        ['name'] = 'Hepatizon Joker',
        ['text'] = {
            [1] = 'Retrigger all played cards {C:attention}#1#{} time(s)',
            [2] = 'Gains {C:attention}+1{} repetition after playing {C:attention}4{}',
            [3] = 'consecutive hands that',
            [4] = 'contains a {C:attention}Straight{} {C:inactive}(#2#/4){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 8
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
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.rep, card.ability.extra.current}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if (next(context.poker_hands["Straight"]) and to_big(card.ability.extra.current) < to_big(3)) then
                return {
                    func = function()
                        card.ability.extra.current = (card.ability.extra.current) + 1
                        return true
                    end,
                    message = localize('k_upgrade_ex')
                }
            elseif (next(context.poker_hands["Straight"]) and to_big(card.ability.extra.current) >= to_big(3)) then
                return {
                    func = function()
                        card.ability.extra.current = 0
                        return true
                    end,
                    message = localize('k_upgrade_ex'),
                    extra = {
                        func = function()
                            card.ability.extra.rep = (card.ability.extra.rep) + 1
                            return true
                        end,
                        colour = G.C.GREEN
                    }
                }
            elseif not (next(context.poker_hands["Straight"])) then
                return {
                    func = function()
                        card.ability.extra.current = 0
                        return true
                    end,
                    message = localize('k_reset')
                }
            end
        end
        if context.forcetrigger then
            return {
            func = function()
                card.ability.extra.rep = (card.ability.extra.rep) + 1
                return true
            end,
            message = localize('k_upgrade_ex')
            }
        end
        if context.repetition and context.cardarea == G.play then
            return {
                repetitions = card.ability.extra.rep,
                message = localize('k_again_ex')
            }
        end
    end
}
