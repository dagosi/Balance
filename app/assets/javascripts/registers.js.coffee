$ ->
    # Sets the correct color to the balance classes.
    set_color_balance = ->
        balances = $('.balance')
        for balance in balances
            # Gets the text of the object which contains the amount.
            raw_balance_amount = $(balance).text().split('$')[1]
            # Deletes the , from the number.
            balance_amount = raw_balance_amount.replace(/\,/g, '')
            if balance_amount < 0
                $(balance).css({"color": 'red'})
            else if balance_amount > 0
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

    # Configures the information and options to be shown in each yer popover.
    year_tab_popover = ->
        $('a.year-tab').popover({
            html: true,
            trigger: 'hover',
            title: '<h4>Year summary</h4>',
            placement: 'right',
            content: ->
                $("div.year-popover-content").html()
        })

    # Configures the information and options to be shown in each payment type popover.
    payment_type_popover = ->
        # Checks if popover's HTML was included in the DOM, if not it means that the register
        # does not have a payment type.
        if $('div.payment-type-popover-content').length > 0
            $('#p').popover({
                html: true,
                trigger: 'hover',
                title: "<h4> #{ $('td.payment_type').text() } Summary</h4>",
                placement: 'right',
                content: ->
                    $("div.payment-type-popover-content").html()
            })

    # This block executes the mothods developed above.
    set_color_balance.call()
    add_active_klass.call()
    hide_paid_field.call()
    year_tab_popover.call()
    payment_type_popover.call()