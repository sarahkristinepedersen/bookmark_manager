require "spec_helper"

feature "User sign up" do

let(:user){build :user}


  def sign_up(user)
    visit '/users/new_user'
    expect(page.status_code).to eq(200)
    fill_in :email,    with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
  end

  scenario "I can sign up as a new user" do
    expect {sign_up(user)}.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, alice@example.com")
    expect(User.first.email).to eq("alice@example.com")
  end

  scenario "requires a matching confirmation password" do
     user = create(:user, password_confirmation: "wrong")
     expect {sign_up(user)}.not_to change(User, :count)
     expect(current_path).to eq("/users")
     expect(page).to have_content "Password does not match the confirmation"
   end

  scenario "without an email address" do
    user = create(:user, email: nil)
    expect {sign_up(user)}.not_to change(User, :count)
    expect(current_path).to eq("/users")
    expect(page).to have_content "Email must not be blank"
  end

  scenario "I cannot sign up with an existing email" do
    sign_up(user)
    expect {sign_up(user)}.to change(User, :count).by(0)
    expect(page).to have_content "Email is already taken"
  end

end


feature 'User sign in' do

  let(:user){create :user}

  def sign_in(email:, password:)
    visit '/sessions/new_session'
    fill_in :email, with: email
    fill_in :password, with: password
    click_button "Sign in"
  end

  scenario "with correct credentials" do
    sign_in(email: user.email, password: user.password)
    expect(page).to have_content "Welcome, #{user.email}"
  end

end


feature 'User signs out' do

  let(:user){create :user}

  scenario 'while being signed in' do
    sign_in(email: 'test@test.com', password: 'test')
    click_button 'Sign out'
    expect(page).to have_content('goodbye!')
    expect(page).not_to have_content('Welcome, test@test.com')
  end

end




# require "spec_helper"

# feature "User sign up" do

  # scenario "I can sign up as a new user" do
  #   visit "/users/new_user"
  #   fill_in :email,    with: "alice@example.com"
  #   fill_in :password, with: "12345678!"
  #   fill_in :password_confirmation, with: "12345678!"
  #   click_button "Sign up"
  #   expect(page).to have_content("Welcome, alice@example.com")
  #   expect(User.first.email).to eq("alice@example.com")
  # end

#-----------------------

#   scenario "I can sign up as a new user" do
#     visit "/users/new_user"
#     fill_in :email,    with: "alice@example.com"
#     fill_in :password, with: "12345678!"
#     fill_in :password_confirmation, with: "12345678!"
#     click_button "Sign up"
#     expect(page).to have_content("Welcome, alice@example.com")
#     expect(User.first.email).to eq("alice@example.com")
#   end


#   scenario "requires a matching confirmation password" do
#     expect{ sign_up(password_confirmation: "wrong") }.not_to change(User, :count)
#   end

#   def sign_up(email: "alice@example.com",
#               password: "12345678",
#               password_confirmation: "12345678")
#     visit "users/new_user"
#     fill_in :email, with: email
#     fill_in :password, with: password
#     fill_in :password_confirmation, with: password_confirmation
#     click_button "Sign up"
#   end

#   scenario "with a password that does not match" do
#     expect { sign_up(password_confirmation: "wrong") }.not_to change(User, :count)
#     expect(current_path).to eq("/users")
#     expect(page).to have_content "Password and confirmation password do not match"
#   end

#   scenario "requires an email for signing up" do
#     expect { sign_up(email: nil) }.not_to change(User, :count)
#     expect(current_path).to eq("/users")
#     expect(page).to have_content "Please enter an email"
#   end

# end