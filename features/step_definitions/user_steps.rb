Given /^a valid user$/ do
  @user = User.create!({
                 :username => "IzIz",
                 :email => "iziz@iziz.com",
                 :password => "123456",
                 :password_confirmation => "123456"
               })

end

Given /^a logged in user$/ do
  Given "a valid user"
  visit login_url
  fill_in "Username", :with => "IzIz"
  fill_in "Password", :with => "123456"
  click_button "Log in"
end
