$ ->
    # Sets the correct color to the balance span.
    set_color_balance_span = ->
        balances = $('span#balance')
        for balance in balances
            if balance.textContent < 0
                $(balance).css({"color": 'red'})
            else if balance.textContent > 0
                $(balance).css({"color": 'green'})

    # Adds the active class to the first tab in the register's index.
    # In addition, adds the active class to the content of the first tab.
    add_active_klass = ->
        $('ul.nav-tabs li:first').addClass('active')
        $('div.tab-content div:first').addClass('active')

    # This block executes the mothods developed above.
    set_color_balance_span.call()
    add_active_klass.call()
