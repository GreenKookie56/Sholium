SMODS.Joker{ --Chocolatebar Quotes
    key = "chocolatebarquotes",
    config = {
        extra = {
            mult = 72
        }
    },
    loc_txt = {
        ['name'] = 'Chocolatebar Quotes',
        ['text'] = {
            [1] = 'In today\'s {C:attention}video{}, {C:attention}five{} of my friends',
            [2] = 'try {C:attention}hunt{} me down and {C:attention}stop{} me',
            [3] = 'from beating {C:attention}Minecraft{}.',
            [4] = 'Can they stop me from beating the',
            [5] = '{C:dark_edition}ender dragon{} or will I {C:attention}survive{}?',
            [6] = 'This is it, {C:blue}Minecraft manhunt versus 5 hunters{},',
            [7] = 'the finale. Also, only a {C:green}small percentage{}',
            [8] = 'of people that watch my videos',
            [9] = 'are actually {C:attention}subscribed{}, so consider subscribing.',
            [10] = 'it\'s {C:green}free{} and you can always change your mind later.',
            [11] = '{C:attention}Enjoy.{}',
            [12] = '{C:inactive}(Actual effect: add one Mult {}',
            [13] = '{C:inactive}for every quote that\'s sent to cbqpl {}',
            [14] = '{C:inactive}as of 2025 August 1st 11:45 UTC+8){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 2,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    mult = card.ability.extra.mult
                }
        end
    end
}
