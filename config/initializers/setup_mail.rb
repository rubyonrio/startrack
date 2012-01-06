ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "example.com.br",
  :user_name            => "bkether@gmail.com",
  :password             => "7bo7ak1c4x9",
  :authentication       => :plain,
  :enable_starttls_auto => true
}
