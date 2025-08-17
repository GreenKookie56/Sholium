SMODS.Joker{ --Glaive Lord (v43)
    key = "glaivelord",
    config = {
        extra = {
            chips = 0,
            chipsmod = 8,
            first = 1
        }
    },
    loc_txt = {
        ['name'] = 'Glaive Lord (v43)',
        ['text'] = {
            [1] = 'This Joker gains {C:blue}+#2#{} Chips',
            [2] = 'for each {C:attention}non-first{} scored card',
            [3] = 'of every {C:attention}hand{}{}',
            [4] = '{C:inactive}(Currently {}{C:blue}+#1#{}{C:inactive} Chips){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 8,
        y = 2
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    soul_pos = {
        x = 9,
        y = 2
    },
    in_pool = function(self, args)
          return not args   or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
      end
    ,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, card.ability.extra.chipsmod}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if (card.ability.extra.first or 0) == 1 then
                card.ability.extra.first = 0
            elseif (card.ability.extra.first or 0) ~= 1 then
                card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.chipsmod
                return {
                    message = "Upgrade!"
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.chips
                }
        end
        if context.after and context.cardarea == G.jokers  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.first = 1
                    return true
                end
                }
        end
    end
}