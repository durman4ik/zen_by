require 'rails_helper'

RSpec.describe Admin, type: :model do

  let(:admin) { FactoryGirl.create(:valid_admin) }

  it 'should have valid factory for Admin' do
    expect(admin).to be_valid
  end

  it 'should require a login' do
    expect(admin, login: nil).to_not be_valid
  end

  it 'should require a password' do
    expect(admin, password: nil).to_not be_valid
  end

  it 'should require a email' do
    expect(admin, email: nil).to_not be_valid
  end

  # it 'password should have a valid length' do
  #   admin.build(:admin, password: '1').should_not be_valid
  # end
end
