SMODS.Joker{ --Ground Zero (pre-nerf)
    key = "groundzero",
    config = {
        extra = {
            chips = 700
        }
    },
    loc_txt = {
        ['name'] = 'Ground Zero (pre-nerf)',
        ['text'] = {
            [1] = '{C:blue}+700{} Chips for the',
            [2] = 'first hand of the round',
            [3] = '{s:0.8,C:inactive}wait this ain\'t the one from bloonalatro{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 3
    },
    cost = 8,
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
            
          or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end
    ,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}