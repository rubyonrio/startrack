#encoding: utf-8
module UsersHelper
  def show_user_avatar(user)
   image_tag avatar_url(user), :class => "avatar icon" unless user.nil?
  end

  private
  def avatar_url(user)
    if user.url_image?
      user.url_image
    else
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
    end
  end
end
