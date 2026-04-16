require "test_helper"
require "capybara/cuprite"

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, window_size: [ 1400, 1400 ], headless: true)
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :rack_test
end

class JavaScriptSystemTestCase < ApplicationSystemTestCase
  driven_by :cuprite
end
