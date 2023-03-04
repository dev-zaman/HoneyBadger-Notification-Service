# frozen_string_literal: true

class SlackNotifier
  def initialize
    @url = ENV['SLACK_WEBHOOK_URL']
  end

  def send_alert(email)
    message = "Spam notification received for #{email}"
    payload = { text: message }.to_json
    RestClient.post(@url, payload, content_type: :json)
  end
end
  