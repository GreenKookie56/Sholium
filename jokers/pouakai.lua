SMODS.Joker{ --Pouakai
    key = "pouakai",
    config = {
        extra = {
            handsizemod = 2
        }
    },
    loc_txt = {
        ['name'] = 'Pouakai',
        ['text'] = {
            [1] = '{C:attention}+#1#{} hand size',
            [2] = 'when a {C:attention}hand{} is played'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 9,
        y = 4
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
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
      end
    ,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.handsizemod}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.handsizemod).." Hand Size", colour = G.C.BLUE})
                G.hand:change_size(card.ability.extra.handsizemod)
                return true
            end
                }
        end
    end
}