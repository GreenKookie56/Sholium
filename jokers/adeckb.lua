SMODS.Joker{ --A deck of Trading cards
    key = "adeckb",
    config = {
        extra = {
            discard_change = 52,
            dollars = 3
        }
    },
    loc_txt = {
        ['name'] = 'A deck of Trading cards',
        ['text'] = {
            [1] = '{C:red}+52{} discards',
            [2] = 'Earn {C:money}$3{} and {C:red}destroy{} discarded',
            [3] = 'cards if only {C:attention}1{} card',
            [4] = 'is discarded'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 1
    },
    cost = 52,
    rarity = 2,
    blueprint_compat = false,
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

    calculate = function(self, card, context)
        if context.discard  and not context.blueprint then
            if #context.full_hand == 1 then
                return {
                    remove = true,
                  message = "Destroyed!"
                }
            end
        end
        if context.pre_discard  then
            if #context.full_hand == 1 then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discard_change
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discard_change
    end
}