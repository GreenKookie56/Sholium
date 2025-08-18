SMODS.Joker{ --The Blazing Sun (v49)
    key = "theblazingsun",
    config = {
        extra = {
            Remaining = 4,
            mult = 55
        }
    },
    loc_txt = {
        ['name'] = 'The Blazing Sun (v49)',
        ['text'] = {
            [1] = '{C:red}+55{} Mult every {C:attention}5{} hands played',
            [2] = '{C:inactive}#1# remaining{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 7,
        y = 5
    },
    cost = 2,
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

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Remaining}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (card.ability.extra.Remaining or 0) <= 0 then
                card.ability.extra.Remaining = 4
                return {
                    mult = card.ability.extra.mult
                }
            else
                card.ability.extra.Remaining = math.max(0, (card.ability.extra.Remaining) - 1)
            end
        end
    end
}