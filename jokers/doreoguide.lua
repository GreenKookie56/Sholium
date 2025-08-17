SMODS.Joker{ --Doreo Guide
    key = "doreoguide",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Doreo Guide',
        ['text'] = {
            [1] = 'This Joker gives {C:red}+10{} Mult',
            [2] = 'for every {C:attention}working{} doreo\'s guide',
            [3] = '{C:inactive}(Currently {}{C:red}+0{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 1
    },
    cost = 1,
    rarity = 1,
    blueprint_compat = true,
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
    
}