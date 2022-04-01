# frozen_string_literal: true

# HomeController
class HomeController < ApplicationController
  def index
    response = Twitch::Request.new.call
    @trending_streams = response.data['data'] if response.success?
  end
end
