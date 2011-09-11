ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "rubyonrio.org",
  :user_name            => "startrack@rubyonrio.org",
  :password             => "star!track.",
  :authentication       => :plain,
  :enable_starttls_auto => true
}
