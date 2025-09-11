if not next(SMODS.find_mod("Cryptid")) then
  return nil
end

SMODS.Joker{ --Buchi
    key = "buchi",
    config = {
        extra = {
            mult = 0.9,
            active = 0,
            scale = 0.05
        }
    },
    loc_txt = {
        ['name'] = 'Buchi',
        ['text'] = {
            [1] = '{X:legendary,C:white}^#1#{} Mult',
            [2] = 'Decrease by {X:legendary,C:white}#3#{}',
            [3] = 'when a hand is played',
            [4] = 'Permanently sets to {X:legendary,C:white}^3.57{} Mult',
            [5] = 'once this reaches {X:legendary,C:white}0{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = "cry_epic",
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.active, card.ability.extra.scale}}
    end,

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if ((card.ability.extra.active or 0) == 0 and (card.ability.extra.mult or 0) > 0) and not context.forcetrigger then
                return {
                    func = function()
                    card.ability.extra.mult = math.max(0, (card.ability.extra.mult) - card.ability.extra.scale)
                    return true
                end
                }
            elseif ((card.ability.extra.active or 0) == 0 and (card.ability.extra.mult or 0) <= 0) and not context.forcetrigger then
                return {
                    func = function()
                    card.ability.extra.mult = 3.57
                    return true
                end,
                    extra = {
                        func = function()
                    card.ability.extra.active = 1
                    return true
                end,
                        colour = G.C.BLUE
                        }
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
                return {
                    e_mult = card.ability.extra.mult
                }
        end
        if context.forcetrigger and card.ability.extra.active == 0 then
                return {
                    func = function()
                    card.ability.extra.mult = 3.57
                    return true
                end,
                    extra = {
                        func = function()
                    card.ability.extra.active = 1
                    return true
                end,
                        colour = G.C.BLUE
                        }
                }
        end
        if context.forcetrigger and card.ability.extra.active ~= 0 then
                return {
                    e_mult = card.ability.extra.mult
                }
        end
    end
}
