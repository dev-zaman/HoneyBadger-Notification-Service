require 'rails_helper'

RSpec.describe Api::V1::NotificationsController, type: :controller do
  before do
    allow(SlackNotifier).to receive(:new).and_return(instance_double(SlackNotifier, send_alert: true))
  end

  describe 'POST #create' do
    let(:valid_payload) do
      {
        'Type' => 'SpamNotification',
        'Email' => 'john@example.com'
      }.to_json
    end

    context 'when the payload is valid' do
      let(:slack_notifier_instance) { instance_double(SlackNotifier) }

      before do
        allow(SlackNotifier).to receive(:new).and_return(slack_notifier_instance)
        allow(slack_notifier_instance).to receive(:send_alert).and_return(true)
        request.headers['Authorization'] = "Token #{ENV['AUTH_TOKEN']}"
        post :create, body: valid_payload
      end

      it 'returns HTTP success' do
        expect(response).to have_http_status(:ok)
      end

      it 'sends a Slack alert' do
        expect(SlackNotifier).to have_received(:new)
        expect(slack_notifier_instance).to have_received(:send_alert).with('john@example.com')
      end
    end

    context 'when the payload is invalid' do
      before do
        request.headers['Authorization'] = "Token #{ENV['AUTH_TOKEN']}"
        post :create, body: { 'Type' => 'InvalidPayloadType', 'Email' => 'jane@example.com' }.to_json
      end

      it 'returns HTTP bad request' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not send a Slack alert' do
        expect(SlackNotifier).not_to have_received(:new)
      end
    end

    context 'when the authentication fails' do
      before do
        request.headers['Authorization'] = 'Token invalid_token'
        post :create, body: valid_payload
      end

      it 'returns HTTP unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'does not send a Slack alert' do
        expect(SlackNotifier).not_to have_received(:new)
      end
    end
  end
end
