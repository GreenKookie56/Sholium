SMODS.Joker{ --Free Dart Monkey
    key = "freedartmonkey",
    config = {
        extra = {
            chips = 30,
            mult = 3,
            cash = 1
        }
    },
    loc_txt = {
        ['name'] = 'Free Dart Monkey',
        ['text'] = {
            [1] = '{C:blue}+#1#{} Chips',
            [2] = '{C:red}+#2#{} Mult',
            [3] = 'Earn {C:gold}$#3#{} when bought'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 9,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 1,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
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

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.cash}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    chips = card.ability.extra.chips,
                    extra = {
                        mult = card.ability.extra.mult
                        }
                }
        end
        if context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers  then
                return {
                    dollars = card.ability.extra.cash
                }
        end
    end
}