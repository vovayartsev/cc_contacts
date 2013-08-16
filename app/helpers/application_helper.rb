module ApplicationHelper

  def avatar_image_tag
    if session[:avatar_url].present?
      image_tag session[:avatar_url], :width => 50, :height => 50
    end
  end
end
