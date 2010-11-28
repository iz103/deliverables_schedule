Given /^a valid user$/ do
  @user = User.create!({
                 :username => "IzIz",
                 :email => "iziz@iziz.com",
                 :password => "123456",
                 :password_confirmation => "123456"
               })
end
