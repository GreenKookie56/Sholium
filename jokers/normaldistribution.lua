SMODS.Joker{ --Normal distribution
    key = "normaldistribution",
    config = {
        extra = {
            Xmult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Normal distribution',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{} Mult for each {C:attention}7{}',
            [2] = 'contained in played hand',
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 5
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local total = 1
            for k, v in ipairs(context.full_hand) do
                if v:get_id() == 7 then
                    total = total + card.ability.extra.Xmult
                end
            end
            if total > 1 then
                return {
                    x_mult = total
                }
            end
		end
    end
}
