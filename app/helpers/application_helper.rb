module ApplicationHelper

  def avatar_image_tag
    if user_logged_in?
      image_tag current_user_avatar_url, :width => 40, :height => 40
    end
  end

  def change_account_link
    if user_logged_in?
      link_to simple_format(I18n.t('menu.change_account')), google_auth_path
    end
  end

  def google_auth_path
    "/auth/google_oauth2"
  end

end
