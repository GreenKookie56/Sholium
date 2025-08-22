SMODS.Joker{ --A deck of Flash cards
    key = "adeck9",
    config = {
        extra = {
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'A deck of Flash cards',
        ['text'] = {
            [1] = 'This Joker gains {C:red}+52{} Mult',
            [2] = 'when {C:green}shop{} is {C:attention}rerolled{}',
            [3] = '{C:inactive}(Currently{} {C:red}+#1#{} {C:inactive}Mult){}',
            [4] = '{C:inactive,s:0.8}1 flash card for each alphabet{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
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

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,

    calculate = function(self, card, context)
        if context.reroll_shop  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.mult = (card.ability.extra.mult) + 52
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