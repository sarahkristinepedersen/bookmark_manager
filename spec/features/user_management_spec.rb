require "spec_helper"

feature "User sign up" do

  scenario "I can sign up as a new user" do
    visit "/users/new_user"
    fill_in :email,    with: "sarah@example.com"
    fill_in :password, with: "Hell0World!"
    click_button "Sign up"
    expect(page).to have_content("Welcome, sarah@example.com")
    expect(User.first.email).to eq("sarah@example.com")
  end

end



# require "spec_helper"

# feature "User sign up" do

#   scenario "I can sign up as a new user" do
#     expect { sign_up }.to change(User, :count).by(1)
#     expect(page).to have_content("Welcome, alice@example.com")
#     expect(User.first.email).to eq("alice@example.com")
#   end

#   def sign_up(email: "alice@example.com",
#               password: "oranges!")
#     visit "/users/new_user"
#     expect(page.status_code).to eq(200)
#     fill_in :email,    with: email
#     fill_in :password, with: password
#     click_button "Sign up"
#   end

# end

