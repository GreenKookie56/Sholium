SMODS.Joker{ --Jugger nut Hole
    key = "juggernuthole",
    config = {
        extra = {
            repetitions = 6
        }
    },
    loc_txt = {
        ['name'] = 'Jugger nut Hole',
        ['text'] = {
            [1] = 'If played hand contains',
            [2] = '{C:attention}Five of a Kind{} or {C:attention}Flush House{},',
            [3] = '{C:attention}Retrigger{} all played cards {C:attention}6{} times'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 9,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'sho' 
          or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if (next(context.poker_hands["Five of a Kind"]) or next(context.poker_hands["Flush House"])) then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}