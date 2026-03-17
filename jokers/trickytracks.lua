
SMODS.Joker{ --Tricky tracks
    key = "trickytracks",
    config = {
        extra = {
            mult = 1,
            scale = 0.3
        }
    },
    loc_txt = {
        ['name'] = 'Tricky tracks',
        ['text'] = {
            [1] = '{X:red,C:white}XMult{} increases once if',
            [2] = 'played hand is {C:attention}Three of a Kind{}',
            [3] = '{X:red,C:white}XMult{} scales faster the further',
            [4] = 'it is away from {X:red,C:white}X3{} Mult',
            [5] = '{C:inactive}(Currently {}{X:red,C:white}X#1#{}{C:inactive} Mult, increases by{} {X:red,C:white}#2#{}{C:inactive}){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mult, card.ability.extra.scale}}
    end,
    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if context.scoring_name == "Three of a Kind" then
                return {
                    func = function()
                        card.ability.extra.mult = lenient_bignum(card.ability.extra.mult) + lenient_bignum(card.ability.extra.scale)
                        return true
                    end,
                    message = "Upgrade!",
                    extra = {
                        func = function()
                            card.ability.extra.scale = lenient_bignum(math.abs(3 - card.ability.extra.mult) * 0.1 + 0.1)
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.mult
            }
        end
        if context.forcetrigger then
            return {
                func = function()
                        card.ability.extra.mult = lenient_bignum(card.ability.extra.mult) + lenient_bignum(card.ability.extra.scale)
                        return true
                end,
                message = "Upgrade!",
                extra = {
                    func = function()
                        card.ability.extra.scale = lenient_bignum(math.abs(3 - card.ability.extra.mult) * 0.1 + 0.1)
                        return true
                    end,
                    colour = G.C.BLUE
                    }
                }
        end
    end
}

