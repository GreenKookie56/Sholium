SMODS.Joker{ --A deck of Red cards
    key = "adeck8",
    config = {
        extra = {
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'A deck of Red cards',
        ['text'] = {
            [1] = 'This Joker gains {C:mult}+156{} Mult',
            [2] = 'when any {C:orange}Booster Pack{} is skipped',
            [3] = '{C:inactive}(Currently{} {C:red}+#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 1
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

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,

    calculate = function(self, card, context)
        if context.skipping_booster  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.mult = (card.ability.extra.mult) + 156
                    return true
                end,
                    message = "Upgrade!"
                }
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    mult = card.ability.extra.mult
                }
        end
    end
}