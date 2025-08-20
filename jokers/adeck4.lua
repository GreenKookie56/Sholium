SMODS.Joker{ --A deck of Xchips
    key = "adeck4",
    config = {
        extra = {
            xchips = 52
        }
    },
    loc_txt = {
        ['name'] = 'A deck of Xchips',
        ['text'] = {
            [1] = '{X:blue,C:white}X1{} Chips for every cards',
            [2] = 'in  a {C:attention}standard 52-card deck{}',
            [3] = '{C:inactive}(X52){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
    },
    cost = 52,
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
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    x_chips = card.ability.extra.xchips
                }
        end
    end
}