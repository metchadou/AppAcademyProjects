require 'json'

class Flash
  attr_reader :now

  def initialize(req)
    cookie = req.cookies['_rails_lite_app_flash']

    @now = cookie ? JSON.parse(cookie) : {}
    @flash = {}
  end

  def [](key)
    @now[key.to_s] || @flash[key.to_s]
  end

  def []=(key, val)
    @flash[key.to_s] = val
  end

  def store_flash(res)
    res.set_cookie(
      '_rails_lite_app_flash',
      { path: '/', value: @flash.to_json }
    )
  end

end


# This is my first attempt.

# class Flash
#   attr_reader :now
#   def initialize(req)
#     @now = {}
#     flash = req.cookies["_rails_lite_app_flash"]
    
#     if flash.nil?
#       @flash = {"cycle" => 1}
#     else
#       @flash = JSON.parse(flash)
#     end
#   end

#   def [](key)
#     @now[key.to_s] || @flash[key.to_s]
#   end

#   def []=(key, val)
#     @flash[key] = val
#   end

#   def store_flash(res)
#     if @flash["cycle"] == 2
#       res.delete_cookie("_rails_lite_app_flash")
#     else
#       @flash["cycle"] += 1
#       res.set_cookie(
#         "_rails_lite_app_flash",
#         {path: '/', value: @flash.to_json})
#     end
#   end

# end