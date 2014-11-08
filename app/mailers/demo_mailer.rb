class DemoMailer < ActionMailer::Base
  default from: "notifications@#{I18n.t(:domain)}", to: ["geoff@safeshepherd.com","robert@safeshepherd.com"]

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.demo_mailer.new_demo.subject
  #
  def new_demo(demo)
    @demo = demo

    mail
  end
end
