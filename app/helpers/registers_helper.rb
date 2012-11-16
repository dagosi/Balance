module RegistersHelper
  def show_paid_status(register)
    if register.balance_type == 'Incoming'
      return '------'
    else
      return show_paid_status_icon(register.paid)
    end
  end

  def show_paid_status_icon(is_register_paid)
    image_name = ""
    if is_register_paid
      image_name = 'yes.ico'
    else
      image_name = 'no.ico'
    end
    image_tag(image_name,size: "30x30")
  end
end
