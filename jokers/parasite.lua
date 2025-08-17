SMODS.Joker{ --Parasite
    key = "parasite",
    config = {
        extra = {
            mult = 0,
            mod = 6
        }
    },
    loc_txt = {
        ['name'] = 'Parasite',
        ['text'] = {
            [1] = 'This Joker gains {C:red}+#2#{} Mult',
            [2] = 'for the {C:attention}last{} played hand',
            [3] = '{C:inactive}(Currently{} {C:red}+#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 4
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
          return not args   or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
      end
    ,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.mod}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    mult = card.ability.extra.mult
                }
        end
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if G.GAME.current_round.hands_left == 0 then
                return {
                    func = function()
                    card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mod
                    return true
                end,
                    message = "Upgrade!"
                }
            end
        end
    end
}