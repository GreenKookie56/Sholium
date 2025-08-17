SMODS.Joker{ --Ezili
    key = "ezili",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Ezili',
        ['text'] = {
            [1] = '{C:purple}Balances{} {C:blue}Chips{} and {C:red}Mult{}',
            [2] = 'on {C:attention}Boss Blind{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 2
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
          return not args   or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
      end
    ,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if G.GAME.blind.boss then
                return {
                    balance = true,
                    message = "Hex"
                }
            end
        end
    end
}