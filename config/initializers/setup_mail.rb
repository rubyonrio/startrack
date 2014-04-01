ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "immobil.com.br",
  :user_name            => "startrack@immobil.com.br",
  :password             => "startrack!2011",
  :authentication       => :plain,
  :enable_starttls_auto => true
}
