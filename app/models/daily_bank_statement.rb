# == Schema Information
#
# Table name: daily_bank_statements
#
#  id                 :integer          not null, primary key
#  number             :string           not null
#  statement_date     :datetime         not null
#  previous_amount    :decimal(15, 4)
#  new_amout          :decimal(15, 4)
#  reserved_amount    :decimal(15, 4)
#  total_payment      :decimal(15, 4)
#  total_payout       :decimal(15, 4)
#  company_account_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class DailyBankStatement < ActiveRecord::Base
  belongs_to :company_account
  has_many :daily_statements, dependent: :destroy

  validates :number, presence: true,
                     uniqueness: true,
                     case_sensitive: false
  validates :statement_date, presence: true
  validates :new_amout, presence: true
  validates :previous_amount, presence: true
  validates :reserved_amount, presence: true
  validates :statement_date, presence: true
  validates :total_payment, presence: true
  validates :total_payout, presence: true
end
