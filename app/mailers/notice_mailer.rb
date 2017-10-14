class NoticeMailer < ActionMailer::Base
  default from: "from@example.com"



  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_test.subject
  #
  def sendmail_test(user,current_user)
    @user = user
    @current_user = current_user
    mail(from: current_user.email,to:@user.email, subject: current_user.name + 'さんにフォローされました')
  end
end
