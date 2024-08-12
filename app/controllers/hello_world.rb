# frozen_string_literal: true

# Basic controller
def hello_world_ctrl(_env)
  [200, { 'Content-Type' => 'text/plain' }, ['Hello, World']]
end
