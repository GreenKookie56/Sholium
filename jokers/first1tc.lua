SMODS.Joker{ --First 1tc
    key = "first1tc",
    config = {
        extra = {
            chips = 650,
            Xmult = 25
        }
    },
    loc_txt = {
        ['name'] = 'First 1tc',
        ['text'] = {
            [1] = '{C:blue}+650{} Chips {X:red,C:white}X25{} Mult if',
            [2] = 'no other jokers are present'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 2
    },
    cost = 10,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
          return not args or args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' and args.source ~= 'rta' and args.source ~= 'sou' and args.source ~= 'uta' and args.source ~= 'wra' or args.source == 'sho'
      end
    ,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if #G.jokers.cards == 1 then
                return {
                    chips = card.ability.extra.chips,
                    extra = {
                        Xmult = card.ability.extra.Xmult
                        }
                }
            end
        end
    end
}