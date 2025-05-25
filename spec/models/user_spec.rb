require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:change_logs).dependent(:nullify) }
  end
end
