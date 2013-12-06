module ApplicationHelper

  def avatar_image_tag
    image_tag current_user_avatar_url, :width => 40, :height => 40
  end

  def change_account_link
    link_to simple_format(I18n.t('menu.change_account')), google_auth_path
  end

  def google_auth_path
    "/auth/google_oauth2"
  end

  def link_to_cc_wiki
    link_to "CC WiKi", "http://wiki.cloudcastlegroup.ru/wiki/%D0%A7%D0%B5%D0%BB%D0%BE%D0%B2%D0%B5%D0%BA%D0%B8"
  end

end
