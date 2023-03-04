require 'rails_helper'

RSpec.describe SlackNotifier do
  describe '#send_alert' do
    let(:slack_notifier) { SlackNotifier.new }
    let(:email) { 'test@example.com' }
    let(:expected_message) { "Spam notification received for #{email}" }

    before do
      ENV['SLACK_WEBHOOK_URL'] = 'http://example.com/slack_webhook'
      allow(RestClient).to receive(:post)
    end

    after do
      ENV.delete('SLACK_WEBHOOK_URL')
    end

    it 'calls the Slack webhook with the expected message' do
      slack_notifier.send_alert(email)
      expect(RestClient).to have_received(:post).with(
        'http://example.com/slack_webhook',
        { text: expected_message }.to_json,
        content_type: :json
      )
    end
  end
end
