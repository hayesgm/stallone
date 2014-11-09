FactoryGirl.define do
  factory :user do
    auth_token "validAuth"
    phone_number "5551212"
    uuid "MyString"
    public_key nil
    private_key nil
  end

end
