SMODS.Joker{ --Corvus (v40)
    key = "corvus",
    config = {
        extra = {
            Remaining = 2,
            chips = 8000,
            Spectral = 0
        }
    },
    loc_txt = {
        ['name'] = 'Corvus (v40)',
        ['text'] = {
            [1] = '{C:blue}+#2#{} Chips and',
            [2] = 'Create an {C:spectral}Immolate{}',
            [3] = 'every {C:attention}3{} played hands',
            [4] = '{C:inactive}#1# remaining{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 6,
        y = 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    soul_pos = {
        x = 7,
        y = 1
    },
    in_pool = function(self, args)
          return (
          not args 
            
          or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end
    ,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Remaining, card.ability.extra.chips}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  and not context.blueprint then
            if (card.ability.extra.Remaining or 0) <= 0 then
                local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Spectral', key = 'c_immolate', key_append = 'joker_forge_spectral'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                card.ability.extra.Remaining = 2
                return {
                    chips = card.ability.extra.chips,
                    extra = {
                        message = created_consumable and localize('k_plus_spectral') or nil,
                        colour = G.C.SECONDARY_SET.Spectral
                        }
                }
            else
                card.ability.extra.Remaining = math.max(0, (card.ability.extra.Remaining) - 1)
            end
        end
    end
}