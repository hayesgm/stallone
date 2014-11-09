FactoryGirl.define do
  factory :user do
    auth_token "validAuth"
    phone_number "MyString"
    uuid "MyString"
    public_key nil
    private_key nil
  end

end
