# frozen_string_literal: true

require 'rails_helper'

describe TwitchersController do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'results' do
    let(:search_params) { { search_term: 'ar' } }

    let(:channels_data) do
      data = File.read(File.join(Rails.root, 'spec', 'fixtures', 'channels.json'))
      JSON.parse(data)
    end

    let(:streams_data) do
      data = File.read(File.join(Rails.root, 'spec', 'fixtures', 'streams.json'))
      JSON.parse(data)
    end

    let(:channels_response) { Result.new(data: channels_data, errors: []) }
    let(:streams_response) { Result.new(data: streams_data, errors: []) }

    context 'feeling lucky search' do

      it 'returns 200 status code' do
        post 'results', params: search_params.merge(button: 'feeling_lucky'), xhr: true

        expect(response).to be_successful
        expect(response).to render_template(:results)
      end

      it 'sets channels and streams' do
        post 'results', params: search_params.merge(button: 'feeling_lucky'), xhr: true

        expect(assigns[:channels]).not_to be_nil
        expect(assigns[:streams]).not_to be_nil
        expect(assigns[:streams].first).to have_key('in_top_20')
      end
    end
  end
end
