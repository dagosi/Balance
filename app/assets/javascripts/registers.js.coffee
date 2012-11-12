$ ->

    # Sets the correct color to the balance span.
    set_color_balance_span = ->
        balance = $('span#balance')

        if balance.text() < 0
            $(balance).css({"color": 'red'})
        else if balance.text() > 0
            $(balance).css({"color": 'green'})


    set_color_balance_span.call()