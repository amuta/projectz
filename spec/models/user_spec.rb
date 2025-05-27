require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email_address) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:change_logs).dependent(:nullify) }
    it { is_expected.to have_many(:sessions).dependent(:destroy) }
  end

  describe 'normalization' do
    it 'normalizes email_address' do
      user = build(:user, email_address: "EmailNotNormalized@Email.com", password: "password123")

      expect(user.email_address).to eq("emailnotnormalized@email.com")
      expect(user).to be_valid
      user.save
      expect(user.reload.email_address).to eq("emailnotnormalized@email.com")
    end
  end
end
