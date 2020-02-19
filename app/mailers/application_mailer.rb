class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@kamarks.com', charset: 'ISO-2022-JP'
  layout 'mailer'
end
