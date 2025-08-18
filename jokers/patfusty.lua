SMODS.Joker{ --Pat Fusty
    key = "patfusty",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Pat Fusty',
        ['text'] = {
            [1] = '{C:attention}+100{} Card selection limit',
            [2] = '{C:inactive}big monke{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 6,
        y = 4
    },
    cost = 7,
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
            
          or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end
    ,

    calculate = function(self, card, context)
    end,

    add_to_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(100)
        SMODS.change_discard_limit(100)
    end,

    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(-100)
        SMODS.change_discard_limit(-100)
    end
}