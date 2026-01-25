SMODS.Joker{ --Pouakai (v36-38)
    key = "pouakai",
    config = {
        extra = {
            handsizemod = 1,
            basehandsize = 8
        }
    },
    loc_txt = {
        ['name'] = 'Pouakai (v36-38)',
        ['text'] = {
            [1] = '{X:attention,C:white}=#2#{} hand size',
            [2] = 'when {C:attention}Blind{} is selected',
            [3] = '{C:attention}+#1#{} hand size',
            [4] = 'when a {C:attention}hand{} is played'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 9,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'jud' and args.source ~= 'rif' and args.source ~= 'sou' and args.source ~= 'uta' and args.source ~= 'wra' 
          or args.source == 'sho' or args.source == 'buf' or args.source == 'rta'
          )
          and true
      end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.handsizemod, card.ability.extra.basehandsize}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.handsizemod).." Hand Size", colour = G.C.BLUE})
                G.hand:change_size(card.ability.extra.handsizemod)
                return true
            end
                }
        end
        if context.setting_blind  and not context.blueprint then
                return {
                    func = function()
                local current_hand_size = G.hand.config.card_limit
                local target_hand_size = card.ability.extra.basehandsize
                local difference = target_hand_size - current_hand_size
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Hand Size set to "..tostring(card.ability.extra.basehandsize), colour = G.C.BLUE})
                G.hand:change_size(difference)
                return true
            end
                }
        end
        if context.selling_self  and not context.blueprint then
                return {
                    func = function()
                local current_hand_size = G.hand.config.card_limit
                local target_hand_size = card.ability.extra.basehandsize
                local difference = target_hand_size - current_hand_size
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Hand Size set to "..tostring(card.ability.extra.basehandsize), colour = G.C.BLUE})
                G.hand:change_size(difference)
                return true
            end
                }
        end
    end
}
