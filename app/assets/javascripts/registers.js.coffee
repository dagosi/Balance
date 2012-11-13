$ ->
    # Sets the correct color to the balance span.
    set_color_balance_span = ->
        balances = $('span#balance')
        for balance in balances
            if balance.textContent < 0
                $(balance).css({"color": 'red'})
            else if balance.textContent > 0
                $(balance).css({"color": 'green'})

    set_color_balance_span.call()