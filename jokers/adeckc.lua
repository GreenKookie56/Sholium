SMODS.Joker{ --A deck of Gift cards
    key = "adeckc",
    config = {
        extra = {
            sell_value = 52
        }
    },
    loc_txt = {
        ['name'] = 'A deck of Gift cards',
        ['text'] = {
            [1] = 'Add {C:money}$1{} of sell value to',
            [2] = 'all {C:attention}Jokers{} and {C:attention}Consumables{}',
            [3] = 'for every cards',
            [4] = 'in  a {C:attention}standard 52-card deck{}',
            [5] = 'at the end of round',
            [6] = '{C:inactive}(+52){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 0
    },
    cost = 312,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'uta' 
          or args.source == 'sho' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'wra'
          )
          and true
      end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
                return {
                    func = function()
            for _, area in ipairs({ G.jokers, G.consumeables }) do
                for i, other_card in ipairs(area.cards) do
                    if other_card.set_cost then
                        other_card.ability.extra_value = (other_card.ability.extra_value or 0) + card.ability.extra.sell_value
                        other_card:set_cost()
                    end
                end
            end
                    return true
                end,
                    message = "Upgrade!"
                }
        end
    end
}