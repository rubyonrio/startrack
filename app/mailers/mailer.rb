class Mailer < Devise::Mailer

  def reset_password_instructions(record)
    devise_mail(record, :reset_password_instructions)
  end
end
