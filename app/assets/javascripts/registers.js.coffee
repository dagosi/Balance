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

    # Hides the paid field while registering a register if the balance
    # type is incoming.
    hide_paid_field = ->
        $('#register_balance_type').change ->
            if $(@).val() == 'Incoming'
                $('#register_paid_input').hide()
            else
                $('#register_paid_input').show()

    # Sets the mask for currencies on new register in the amount field.
    set_mask = ->
        $('#register_amount').priceFormat ->
            prefix: 'R$ ',
            centsSeparator: ',',
            thousandsSeparator: '.'

    # This block executes the mothods developed above.
    set_color_balance_span.call()
    add_active_klass.call()
    hide_paid_field.call()
