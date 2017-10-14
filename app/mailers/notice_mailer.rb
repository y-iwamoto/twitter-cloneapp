class NoticeMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_test.subject
  #
  def sendmail_test
    @greeting = "Hi"

    mail to: "y-iwamoto@answer.co.jp"
    subject: '【Achieve】ブログが投稿されました'
  end
end
