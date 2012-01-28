#encoding: utf-8
module UsersHelper
  def show_user_avatar(user)
   image_tag avatar_url(user), title: "#{user.name}" unless user.nil?
  end

  private
    def avatar_url(user)
      if user.url_image?
        user.url_image
      else
        "http://gravatar.com/avatar/#{gravatar_id(user)}?s=30"
      end
    end

    def gravatar_id(user)
      Digest::MD5.hexdigest(user.email.downcase)
    end
end
