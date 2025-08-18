SMODS.Joker{ --Nano-virus
    key = "nanovirus",
    config = {
        extra = {
            dollars = 2
        }
    },
    loc_txt = {
        ['name'] = 'Nano-virus',
        ['text'] = {
            [1] = 'Earn {C:gold}$2{}',
            [2] = 'when a card is bought'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 4
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
          return (
          not args 
            
          or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end
    ,

    calculate = function(self, card, context)
        if context.buying_card  then
                return {
                    dollars = card.ability.extra.dollars
                }
        end
    end
}