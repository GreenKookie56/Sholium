SMODS.Joker{ --Neurax worm
    key = "neuraxworm",
    config = {
        extra = {
            mult = 1.5,
            odds = 2
        }
    },
    loc_txt = {
        ['name'] = 'Neurax worm',
        ['text'] = {
            [1] = 'Each card held in hand has a',
            [2] = '{C:green}#2# in #3#{} chance to grant a random',
            [3] = '{C:dark_edition}Negative{} Consumable and {X:legendary,C:white}^#1#{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 4
    },
    cost = 30,
    rarity = "sholium_peculiar",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    soul_pos = {
        x = 2,
        y = 4
    },
    in_pool = function(self, args)
          return not args or args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' and args.source ~= 'rta' and args.source ~= 'sou' and args.source ~= 'uta' and args.source ~= 'wra' or args.source == 'sho'
      end
    ,

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sholium_neuraxworm') 
        return {vars = {card.ability.extra.mult, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_ea22710b', 1, card.ability.extra.odds, 'j_sholium_neuraxworm') then
                      SMODS.calculate_effect({func = function()local created_consumable = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local random_sets = {'Tarot', 'Planet', 'Spectral'}
                        local random_set = random_sets[math.random(1, #random_sets)]
                        SMODS.add_card{set=random_set, edition = 'e_negative', key_append='joker_forge_' .. random_set:lower()}
                        return true
                    end
                }))
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_consumable'), colour = G.C.PURPLE})
                    end
                    return true
                end}, card)
                        SMODS.calculate_effect({e_mult = card.ability.extra.mult}, card)
                  end
            end
        end
    end
}