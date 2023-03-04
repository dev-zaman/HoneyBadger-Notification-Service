# frozen_string_literal: true

class Api::V1::NotificationsController < BaseController
  def create
    payload = JSON.parse(request.body.read)

    if payload['Type'] == 'SpamNotification'
      email = payload['Email']
      SlackNotifier.new.send_alert(email)
      render json: { message: "Spam notification received for #{email}" }, status: :ok
    else
      render json: { message: "Not a spam notification payload" }, status: :bad_request
    end
  end
end
