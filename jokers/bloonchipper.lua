SMODS.Joker{ --Bloonchipper
    key = "bloonchipper",
    config = {
        extra = {
            discard = 0,
            discardmod = 1,
            round = 0
        }
    },
    loc_txt = {
        ['name'] = 'Bloonchipper',
        ['text'] = {
            [1] = '{C:red}+#1#{} discard(s)',
            [2] = 'when {C:attention}Blind{} is selected',
            [3] = 'Increase by {C:red}+#2#{} each {C:attention}Ante{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 7,
        y = 0
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.discard, card.ability.extra.discardmod}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.discard = (card.ability.extra.discard) + card.ability.extra.discardmod
                    return true
                end,
                    message = "Upgrade!"
                }
        end
        if context.setting_blind  then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.discard).." Discard", colour = G.C.ORANGE})
                G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + card.ability.extra.discard
                return true
            end
                }
        end
        if context.forcetrigger then
          return {
            func = function()
                card.ability.extra.discard = (card.ability.extra.discard) + card.ability.extra.discardmod    
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.discard).." Discard", colour = G.C.ORANGE})
                G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + card.ability.extra.discard
                return true
            end
                }
        end
    end
}
