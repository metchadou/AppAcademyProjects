require 'erb'
require 'rack'

class ShowExceptions
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue => exception
      render_exception(exception)
    end
  end

  private

  def render_exception(e)
    dir = File.dirname(__FILE__)
    template_file = File.join(dir, "templates", "rescue.html.erb")
    template_code = File.read(template_file)
    res_body = ERB.new(template_code).result(binding)

    ['500', {'Content-type' => 'text/html'}, [res_body]]

    # res = Rack::Response.new
    # res.status = 500
    # res['Content-type'] = 'text/html'
    # res.write(ERB.new(template_code).result(binding))

    # res.finish
  end

end