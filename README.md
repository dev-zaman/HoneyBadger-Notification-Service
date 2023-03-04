# Slack Alert Endpoint for Spam Notifications
This is a simple Ruby on Rails application that accepts a JSON payload as a POST request and sends an alert to a Slack channel if the payload matches desired criteria.

### Requirements
Ruby (version 2.7 or higher)
Ruby on Rails (version 6 or higher)
A Slack account and webhook URL

### Installation
1. Clone the repository: 
  git clone https://github.com/your-username/slack-alert-endpoint.git

2. Install dependencies:
  cd slack-alert-endpoint
  bundle install

3. Set up the Slack webhook URL:
  3.1 Log in to your Slack account.
  3.2 Go to the Slack webhook creation page.
  3.3 Select the channel where you want to receive notifications and click on the "Add Incoming Webhooks integration" button.
  3.4 On the next page, scroll down to the "Integration Settings" section and click on the "Add New Webhook to Workspace" button.
  3.5 Copy the webhook URL from the "Webhook URL" field. This is the URL you will use to send notifications to your Slack channel.

4. Set up environment variables

  Create a .env file in root directory
  
  ```
  AUTH_TOKEN='For authentication of request'
  SLACK_WEBHOOK_URL='Url of channel you want to send notification in slack'
  ```

5. Start the application:
  rails server

The application will now be running at http://localhost:3000.

### Usage
To send a spam notification to your Slack channel, send a POST request to the /notifications endpoint with a JSON payload that matches the desired criteria. Here's an example payload:

```
{
  "RecordType": "Bounce",
  "Type": "SpamNotification",
  "TypeCode": 512,
  "Name": "Spam notification",
  "Tag": "",
  "MessageStream": "outbound",
  "Description": "The message was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content.",
  "Email": "zaphod@example.com",
  "From": "notifications@honeybadger.io",
  "BouncedAt": "2023-02-27T21:41:30Z"
}
```

If the payload matches the desired criteria, a Slack alert will be sent to the channel specified in the webhook URL. The alert will include the email address included in the payload.

### Deployment
To deploy the application to a production server, follow these steps:

1. Set up a production environment with Ruby and Ruby on Rails installed.
  * Ensure that the production environment meets the minimum requirements for running Ruby on Rails applications, such as having the correct version of Ruby installed.
  * Install any necessary dependencies or libraries that your application requires.
2. Clone the repository onto the production server.
  * Copy the source code of your application to the production server by cloning the repository where the application is stored. Alternatively, you can use a deployment tool like Capistrano to automate this process.
3. Install dependencies with bundle install.
4. Set up the Slack account and get webhook URL for respective channel.
5. Configure your production server to run the application.
  * There are several ways to run a Ruby on Rails application on a production server. Here are a few examples:
    * Use a web server like Nginx or Apache to serve your application.
      * Install and configure the web server to route incoming requests to your application.
    * Use a platform like Heroku to host your application.
      * Create a new app on Heroku and push your application code to the Heroku Git remote.
      * Configure the Heroku app to use the necessary environment variables and add-ons (such as the Slack webhook URL).
    * Use a containerization technology like Docker to package and deploy your application.
      * Create a Dockerfile that specifies the necessary dependencies and configuration for your application.
      * Build a Docker image from the Dockerfile and run a container from the image on your production server.
