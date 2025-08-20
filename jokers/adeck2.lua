SMODS.Joker{ --A deck of Mult
    key = "adeck2",
    config = {
        extra = {
            mult = 380
        }
    },
    loc_txt = {
        ['name'] = 'A deck of Mult',
        ['text'] = {
            [1] = 'Gives {C:red}Mult{} equals the total amount',
            [2] = 'of {C:blue}Chips{} a {C:attention}standard 52-card deck{}',
            [3] = 'provides {C:inactive}(+380){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 0
    },
    cost = 52,
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
          or args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' and args.source ~= 'rta' and args.source ~= 'sou' and args.source ~= 'uta' and args.source ~= 'wra' 
          or args.source == 'sho'
          )
          and true
      end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    mult = card.ability.extra.mult
                }
        end
    end
}