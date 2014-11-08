require "rails_helper"

RSpec.describe DemoMailer, :type => :mailer do
  describe "new_demo" do
    let(:mail) { DemoMailer.new_demo(build(:demo)) }

    it "renders the headers" do
      expect(mail.subject).to eq("New Ambush Demo")
      expect(mail.to).to eq(["geoff@safeshepherd.com","robert@safeshepherd.com"])
      expect(mail.from).to eq(["notifications@ambush.io"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("My company")
      expect(mail.body.encoded).to match("21 to 100")
    end
  end

end
