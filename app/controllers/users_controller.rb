# frozen_string_literal: true

# UsersController
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :build_search_history, only: :add_to_history

  def history
    @versions = current_user.search_histories.last(10)
  end

  def add_to_history
    return unless @search_history.save
    render json: {success: true, stream_user_login: @search_history.stream_user_login}
  end

  private

  def build_search_history
    search_history_params = params[:search_history]
    @search_history = current_user.search_histories.build(
                                                          query: search_history_params[:query],
                                                          results: search_history_params[:results],
                                                          stream_user_login: search_history_params[:search_history_params])
  end
end
