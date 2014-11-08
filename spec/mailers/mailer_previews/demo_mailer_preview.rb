class DemoMailerPreview < ActionMailer::Preview

  def new_demo
    demo = Demo.new(first_name: "Bob", last_name: "Jones", company: "My company")
    DemoMailer.new_demo(demo)
  end

end