class Mailer < Devise::Mailer
  include Resque::Mailer

  def reset_password_instructions(record)
    # attachments['logo.png'] = File.read('')
    devise_mail(record, :reset_password_instructions)
  end
end