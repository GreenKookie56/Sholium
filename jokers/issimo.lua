SMODS.Joker{ --Issimo
    key = "issimo",
    config = {
        extra = {
            ante = 1,
            cash = 35
        }
    },
    loc_txt = {
        ['name'] = 'Issimo',
        ['text'] = {
            [1] = 'Earn {C:gold}$#2#{}, then{C:red} +#1#{} Ante when bought'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 8,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 1,
    rarity = 1,
    blueprint_compat = false,
    demicoloncompat = true,
    eternal_compat = false,
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
        return {vars = {card.ability.extra.ante, card.ability.extra.cash}}
    end,

    calculate = function(self, card, context)
        if context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers or context.forcetrigger then
                return {
                    dollars = card.ability.extra.cash,
                    extra = {
                        func = function()
                    local mod = card.ability.extra.ante
		ease_ante(mod)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + mod
				return true
			end,
		}))
                    return true
                end,
                            message = "Ante +" .. card.ability.extra.ante,
                        colour = G.C.FILTER
                        }
                }
        end
    end
}