require 'rails_helper'

RSpec.describe DailyBankStatement, type: :model do
  before do
    FactoryGirl.create(:daily_bank_statement)
  end	
  it { should validate_uniqueness_of(:number).case_insensitive }
  it { should validate_presence_of(:number) }

  it { should validate_presence_of(:statement_date)}
end
