SMODS.Joker{ --A deck of Gold
    key = "adecka",
    config = {
        extra = {
            dollars = 156
        }
    },
    loc_txt = {
        ['name'] = 'A deck of Gold',
        ['text'] = {
            [1] = 'Earn {C:money}$3{} for every cards',
            [2] = 'in  a {C:attention}standard 52-card deck{}',
            [3] = 'at the end of round',
            [4] = '{C:inactive}(+156){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 0
    },
    cost = 156,
    rarity = 2,
    blueprint_compat = false,
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
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
                return {
                    dollars = card.ability.extra.dollars
                }
        end
    end
}