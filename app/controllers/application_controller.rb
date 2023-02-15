class ApplicationController < ActionController::Base
  include SessionsHelper
  add_flash_types :error, :success
end
