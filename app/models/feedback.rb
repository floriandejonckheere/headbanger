class Feedback < MailForm::Base
  CATEGORIES = ['Bug or error', 'Missing feature', 'Content (artists, albums, ...)', 'Other']

  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :category
  attribute :description

  validates :category,
            :inclusion => { :in => CATEGORIES }

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
        :subject => 'Headbanger feedback',
        :to => 'feedback@thalarion.be',
        :from => Rails.application.config.mailer['default_sender']
    }
  end
end
