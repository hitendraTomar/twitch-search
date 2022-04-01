# frozen_string_literal: true

require 'rails_helper'

describe HomeController do
  let(:user) { create(:user) }

  describe 'index' do
    context 'when user is logged in' do
      let(:streams_data) do
        data = File.read(File.join(Rails.root, 'spec', 'fixtures', 'streams.json'))
        JSON.parse(data)
      end

      let(:twitch_response) { Result.new(data: streams_data, errors: []) }

      before do
        sign_in user

        expect_any_instance_of(Twitch::Request).to receive(:call).once.and_return(twitch_response)
      end

      it 'returns 200 status code' do
        get 'index'

        expect(response).to be_successful
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not logged in' do
      it 'returns 200 status code' do
        get 'index'

        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

    end
  end
end
