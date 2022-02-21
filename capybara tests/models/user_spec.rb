require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) do
    User.new(
      email: 'usermail@mail.com',
      password: 'mypassword')
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe "#is_password?" do
    context "when password is correct" do
      it "returns true" do
        expect(user.is_password?('mypassword')).to be true
      end
    end

    context "when password is incorrect" do
      it "returns false" do
        expect(user.is_password?('wrongpassword')).to be false
      end
    end
  end

  describe "#reset_session_token!" do
    it "resets user session token" do
      old_session_token = user.session_token
      new_session_token = user.reset_session_token!

      expect(new_session_token).not_to eq(old_session_token)
    end
  end
    
  describe "::find_by_credentials" do
    before { user.save! }

    it 'returns user given good credentials' do
      expect(User.find_by_credentials('usermail@mail.com', 'mypassword')).to eq(user)
    end

    it 'returns nil given bad credentials' do
      expect(User.find_by_credentials('usermail@mail.com', 'bad_password')).to eq(nil)
    end
  end
end
