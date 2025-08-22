SMODS.Joker{ --A deck of Baseball cards
    key = "adeck7",
    config = {
        extra = {
            Xmult = 1434648375
        }
    },
    loc_txt = {
        ['name'] = 'A deck of Baseball cards',
        ['text'] = {
            [1] = '{C:uncommon}Uncommon{} Jokers give',
            [2] = '{X:red,C:white}X1434648375{} Mult',
            [3] = '{C:inactive}contains 52 baseball cards{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 0
    },
    cost = 208,
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
          or args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rta' and args.source ~= 'wra' 
          or args.source == 'sho' or args.source == 'rif' or args.source == 'sou' or args.source == 'uta'
          )
          and true
      end,

    calculate = function(self, card, context)
        if context.other_joker  then
            if (function()
    return context.other_joker.config.center.rarity == 2
end)() then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}