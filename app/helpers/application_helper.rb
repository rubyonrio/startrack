module ApplicationHelper
  def avatar_url(user)
    if user.url_image.present?
      user.url_image
    else
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
    end
  end
end
