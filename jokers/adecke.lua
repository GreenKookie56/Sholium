SMODS.Joker{ --A deck of Antimatter
    key = "adecke",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'A deck of Antimatter',
        ['text'] = {
            [1] = 'Gives {C:dark_edition}+1{} Joker slot',
            [2] = 'for every cards in a',
            [3] = '{C:attention}standard 52-card deck{}',
            [4] = '{C:inactive}(+52){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 0
    },
    cost = 530,
    rarity = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'buf' and args.source ~= 'jud' 
          or args.source == 'sho' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end,

    set_ability = function(self, card, initial)
        card:set_edition("e_negative", true)
    end,

    calculate = function(self, card, context)
    end,

    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + 52
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - 52
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_sholium_adecke" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref()
end