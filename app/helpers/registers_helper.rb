module RegistersHelper
  def show_paid_status(register)
    if register.balance_type == 'Incoming'
      return ''
    else
      return register.paid
    end
  end
end
