require 'spec_helper'

describe Demo do
  
  it 'should deliver email after create' do
    demo = build(:demo)
    
    got_demo = nil
    
    mailer = double("mailer")
    expect(mailer).to receive(:deliver)
    expect(DemoMailer).to receive(:new_demo) { |demo| got_demo = demo; mailer }
    demo.save!

    expect(got_demo.id).to eq(demo.id)
  end
end