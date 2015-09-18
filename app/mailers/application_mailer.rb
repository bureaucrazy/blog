class ApplicationMailer < ActionMailer::Base
  default from: "webmaster@myblog.com"
  layout 'mailer'
end
