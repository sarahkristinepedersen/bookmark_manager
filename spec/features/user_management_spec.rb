require "spec_helper"

feature "User sign up" do

  # scenario 'I can sign up as a new user' do
  #   expect { sign_up }.to change(User, :count).by(1)
  #   expect(page).to have_content('Welcome, alice@example.com')
  #   expect(User.first.email).to eq('alice@example.com')
  # end

  scenario "I can sign up as a new user" do
    visit "/users/new_user"
    fill_in :email,    with: "alice@example.com"
    fill_in :password, with: "12345678!"
    fill_in :password_confirmation, with: "12345678!"
    click_button "Sign up"
    expect(page).to have_content("Welcome, alice@example.com")
    expect(User.first.email).to eq("alice@example.com")
  end


  scenario "requires a matching confirmation password" do
    expect{ sign_up(password_confirmation: "wrong") }.not_to change(User, :count)
  end

  def sign_up(email: "alice@example.com",
              password: "12345678",
              password_confirmation: "12345678")
    visit "users/new_user"
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button "Sign up"
  end

end