require 'rack'

class Static
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    match_data = req.path.match(/\/public\/(?<asset>.+)/)

    if match_data
      path = file_path(match_data[:asset])

      if File.exist?(path)
        serve_file(path)
      else
        send_response(404, "text/html", "Not Found")
      end
      
    else
      @app.call(env)
    end
  end

  private

  def file_path(file_name)
    dir = File.dirname(__FILE__)
    File.join(dir, "..", "public", file_name)
  end

  def serve_file(path)
    file_data = File.read(path)
    send_response(200, "text/html", file_data)
  end

  def send_response(status, type, content)
    res = Rack::Response.new
    res.status = status
    res.content_type = type
    res.write(content)

    res.finish
  end

end
