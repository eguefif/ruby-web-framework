# frozen_string_literal: true

require './app/controllers/hello_world'
require './bin/db_engine'

# Main class
class Cartier
  def new
    @db = CartierDBEngine.new
  end

  def call(env)
    router = router_array
    request_route = env['REQUEST_PATH']
    router.each do |route|
      if route[0] == request_route
        status, headers, body = route[1].call(env)
        return [status, headers, body]
      end
    end
    [500, { 'Content-Type' => 'text/plain' }, ['Internal error']]
  end

  def router_array
    [['/', method(:hello_world_ctrl)]]
  end
end

run Cartier.new
