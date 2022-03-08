require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require_relative './session'
require_relative './flash'
require "byebug"

class ControllerBase
  attr_reader :req, :res, :params, :protect_from_forgery

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @params = route_params.merge(req.params)
    @already_built_response = false
    @@protect_from_forgery ||= false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "Double redirect error" if already_built_response?

    @res['location'] = url
    @res.status = 302
    session.store_session(@res)
    flash.store_flash(@res)

    @already_built_response = true
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise "Double render error" if already_built_response?

    @res.write(content)
    @res['content-type'] = content_type
    session.store_session(@res)
    flash.store_flash(@res)

    @already_built_response = true
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    dir_name = File.dirname(__FILE__)

    template_file = File.join(
      dir_name, "..", "views",
      self.class.name.underscore,
      "#{template_name}.html.erb")

    template_data = File.read(template_file)

    render_content(
      ERB.new(template_data).result(binding),
      "text/html")
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  def flash
    @flash ||= Flash.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    if protect_from_forgery? && forgery?
      raise "CSRF ATTACK"
    else
      send(name)
      render(name) unless already_built_response?
    end
  end

  def protect_from_forgery?
    @@protect_from_forgery
  end

  def forgery?
    return false if @req.request_method == "GET"
    check_authenticity_token
  end

  def self.protect_from_forgery
    @@protect_from_forgery = true
  end

  def check_authenticity_token
    @params["authenticity_token"] != session["authenticity_token"]
  end

  def form_authenticity_token
    session["authenticity_token"] = SecureRandom.urlsafe_base64(16)
  end
end

