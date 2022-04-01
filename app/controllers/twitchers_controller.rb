# frozen_string_literal: true

# TwitchersController
class TwitchersController < ApplicationController
  before_action :authenticate_user!

  def search; end

  def results
    if search_params[:search_term].blank?
      @channels = []
      flash[:error] = "Search can't be blank"
      redirect_to search_path
    end
    if params[:button] == 'feeling_lucky'
      query = { first: 20 }
      endpoint = "streams?#{query.to_query}"
    else
      endpoint = "search/channels?query=#{search_params[:search_term]}"
    end
    @response = Twitch::Request.new(endpoint).call

    return unless @response.success?

    @channels = @response.data['data']
    check_for_top_positions
    maintain_search_histories
  end

  private

  def search_params
    params.permit(:search_term, :button)
  end

  def check_for_top_positions
    response = Twitch::Request.new(feeling_lucky).call
    return unless response.success?

    @streams = response.data['data']

    broadcaster_login = @channels.map { |s| s['broadcaster_login'] }

    @cached_ids = []
    history_ids = current_user.history_ids
    @streams.map! do |stream|
      next if params[:button] == 'feeling_lucky' && history_ids.include?(stream['id'])

      @cached_ids.push(stream)
      stream['in_top_20'] = broadcaster_login.include?(stream['user_login'])
      stream
    end

    @streams.compact!
  end

  def feeling_lucky
    if params[:button] == 'feeling_lucky'
      query = { first: 20 }
    else
      query = { first: 40 }
    end
    "streams?#{query.to_query}"
  end

  def maintain_search_histories
    @streams = @streams - searched_results
  end

  def searched_results
    current_user.search_histories.pluck(:results)
  end

end
