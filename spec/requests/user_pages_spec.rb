require 'spec_helper'

describe "User pages" do

    subject { page }

    describe "profile page" do
        let(:user) { FactoryGirl.create(:user) }
        before { visit user_path(user) }
        it { should have_selector('h1', text: user.name ) }
        it { should have_selector('title',text: user.name) }
    end

    describe "Sign-up" do
        before { visit signup_path }
        let(:submit) { "Create my Account"}

        describe "with invalid information" do
            it "should not create a user" do
                expect {click_button submit }.not_to change(User, :count) 
            end
        end

        describe "after submission" do
            before { click_button submit }
            it { should have_selector('title',text: 'Sign up') }
            it { should have_content('error') }
        end

        describe "with valid information" do
            before do
                fill_in "Name", with: "Gaurav Walia"
                fill_in "Email", with: "gaurav.walia24@gmail.com"
                fill_in "Password", with: "gaurav"
                fill_in "Confirmation", with: "gaurav"
            end

            describe "after saving the user" do
                before{ click_button submit }
                let(:user) {User.find_by_email('gaurav.walia24@gmail.com' ) }
                it { should have_selector('title', text: user.name )}
                it { should have_selector('div.alert.alert-success',text: 'Welcome')}
                it { should have_link('Sign out') }
            end

            it "should create a user" do
                expect {click_button submit }.to change(User, :count).by(1) 
            end
        end 
    end
end
