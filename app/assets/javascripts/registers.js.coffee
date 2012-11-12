$ ->

    set_color_balance = ->
        balance = $('span#balance')

        if balance.text() < 0
            $(balance).css({"color": 'red'})
        else if balance.text() > 0
            $(balance).css({"color": 'green'})


    set_color_balance.call()