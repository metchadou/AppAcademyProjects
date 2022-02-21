module ApplicationHelper
  include ERB::Util

  def auth_form
    "<input type=\"hidden\" name=\"authenticity_token\" value=\"#{form_authenticity_token}\">".html_safe
  end

  def form_method(method)
    "<input type=\"hidden\" name=\"_method\" value=\"#{method}\">".html_safe
  end

  def ugly_lyrics(lyrics)
    formatted_lyrics = lyrics.split("\n").map do |line|
      "&#9835; #{line}"
    end.join("\n")

    html = "<pre>"
    html += "#{h(formatted_lyrics)}"
    html += "</pre>"
    
    html.html_safe
  end
end