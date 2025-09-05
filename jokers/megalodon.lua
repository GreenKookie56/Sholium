SMODS.Joker{ --Megalodon
    key = "megalodon",
    config = {
        extra = {
            mult = 700
        }
    },
    loc_txt = {
        ['name'] = 'Megalodon',
        ['text'] = {
            [1] = 'All played cards give {C:red}+#1#{} Mult when {C:attention}scored{}',
            [2] = 'and are {C:red}destroyed{} afterwards',
            [3] = '{C:inactive}Art by 1.2m^2 Fungus Room{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 20,
    rarity = 4,
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
          or args.source ~= 'sho' 
          or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
                context.other_card.should_destroy = true
                return {
                    mult = card.ability.extra.mult,
                    extra = {
                        message = "Thrash!",
                        colour = G.C.RED
                        }
                }
        end
        if context.forcetrigger then
            return {
                mult = card.ability.extra.mult
               }
        end
    end
}