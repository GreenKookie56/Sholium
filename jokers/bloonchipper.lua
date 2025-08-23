SMODS.Joker{ --Bloonchipper
    key = "bloonchipper",
    config = {
        extra = {
            discard = 0,
            discardmod = 1,
            odds = 2,
            round = 0
        }
    },
    loc_txt = {
        ['name'] = 'Bloonchipper',
        ['text'] = {
            [1] = '{C:red}+#1#{} discard(s)',
            [2] = 'when {C:attention}Blind{} is selected',
            [3] = '{C:green}#4# in #5#{} chance to increase by',
            [4] = '{C:red}+#2#{} each {C:attention}Ante{}'
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
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sholium_bloonchipper') 
        return {vars = {card.ability.extra.discard, card.ability.extra.discardmod, card.ability.extra.round, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_0bf57d31', 1, card.ability.extra.odds, 'j_sholium_bloonchipper') then
                      SMODS.calculate_effect({func = function()
                    card.ability.extra.discard = (card.ability.extra.discard) + card.ability.extra.discardmod
                    return true
                end}, card)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Upgrade!", colour = G.C.GREEN})
                  end
            end
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
    end
}