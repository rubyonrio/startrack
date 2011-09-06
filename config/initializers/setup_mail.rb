ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "yourdomain.com.br",
  :user_name            => "user@yourdomain.com.br",
  :password             => "password",
  :authentication       => :plain,
  :enable_starttls_auto => true
}
