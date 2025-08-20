SMODS.Joker{ --A deck of Decks
    key = "adeckd",
    config = {
        extra = {
            chips = 19760
        }
    },
    loc_txt = {
        ['name'] = 'A deck of Decks',
        ['text'] = {
            [1] = 'Gives the total amount of {C:blue}Chips{}',
            [2] = 'a {C:attention}standard 52-card deck{} provides',
            [3] = 'for every cards in a',
            [4] = '{C:attention}standard 52-card deck{}',
            [5] = '{C:inactive}(+19760){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 0
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
                    chips = card.ability.extra.chips
                }
        end
    end
}