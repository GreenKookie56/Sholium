SMODS.Joker{ --A deck of Ascendance
    key = "adeck5",
    config = {
        extra = {
            emult = 52
        }
    },
    loc_txt = {
        ['name'] = 'A deck of Ascendance',
        ['text'] = {
            [1] = '{X:legendary,C:white}^1{} Mult for every cards',
            [2] = 'in  a {C:attention}standard 52-card deck{}',
            [3] = '{C:inactive}(^52){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 0
    },
    cost = 52,
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
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    e_mult = card.ability.extra.emult
                }
        end
    end
}