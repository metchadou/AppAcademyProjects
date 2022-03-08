module ApplicationHelper
  def auth_form
    "<input
        type=\"hidden\"
        name=\"authenticity_token\"
        value=\"#{form_authenticity_token}\">".html_safe
  end

  def http_method(method)
    "<input
        type=\"hidden\"
        name=\"_method\"
        value=\"#{method}\">".html_safe
  end
end
