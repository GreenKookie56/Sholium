
SMODS.Joker{ --Megalodon
    key = "megalodon",
    config = {
        extra = {
            mult = 1,
            chips = 1,
            scale = 1
        }
    },
    loc_txt = {
        ['name'] = 'Megalodon',
        ['text'] = {
            [1] = 'When a {C:red}Mult Card{} / {C:blue}Bonus Card{}',
            [2] = 'is scored, this Joker gains',
            [3] = '{X:red,C:white}X#3#{} Mult / {X:blue,C:white}X#3#{} Chips respectively',
            [4] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{}{C:inactive} Mult, {}{X:blue,C:white}X#2#{}{C:inactive} Chips){}',
            [5] = '{C:inactive}Art by 1.2m^2 Fungus Room{}'
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
        
        return {vars = {card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.scale}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if SMODS.get_enhancements(context.other_card)["m_mult"] == true then
                card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.scale
                return {
                    message = "Upgrade!"
                }
            elseif SMODS.get_enhancements(context.other_card)["m_bonus"] == true then
                card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.scale
                return {
                    message = "Upgrade!"
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.mult,
                x_chips = card.ability.extra.chips,
            }
        end
        if context.forcetrigger then
            return {
                Xmult = card.ability.extra.mult,
                x_chips = card.ability.extra.chips,
            }
        end
    end
}
