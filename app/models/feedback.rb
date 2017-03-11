class Feedback < MailForm::Base
  CATEGORIES = ['Bug or error', 'Missing feature', 'Content (artists, albums, ...)', 'Other']

  attribute :category
  attribute :description

  append :remote_ip, :user_agent

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
        :subject => 'Headbanger feedback',
        :from => ENV['MAILER_FEEDBACK_SENDER'],
        :to => ENV['MAILER_FEEDBACK_RECIPIENT']
    }
  end
end
