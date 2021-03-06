# == Schema Information
#
# Table name: payment_orders
#
#  id                        :integer          not null, primary key
#  debtor_account_number     :string(18)       not null
#  debtor_account_name       :string           not null
#  debtor_account_city       :string           not null
#  debtor_model_number       :string(2)        not null
#  debtor_reference_number   :string           not null
#  debtor_payment_purpose    :string           not null
#  creditor_model_number     :string(2)        not null
#  creditor_reference_number :string           not null
#  creditor_account_number   :string(18)       not null
#  payment_method            :integer          not null
#  approval_reference_number :string           not null
#  payment_number            :string(3)        not null
#  transfer_amount           :decimal(15, 4)   not null
#  currency_date             :datetime         not null
#  payment_date              :datetime         not null
#  account_city              :string           not null
#  payment_forming_id        :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

FactoryGirl.define do
  factory :payment_order do
    debtor_account_number { Faker::Number.number(18) }
    debtor_account_name { Faker::Name.name }
    debtor_account_city { Faker::Address.city }
    debtor_model_number { Faker::Number.number(2) }
    debtor_reference_number { Faker::Number.number(12) }
    debtor_payment_purpose { Faker::Lorem.sentence }

    creditor_model_number { Faker::Number.number(2) }
    creditor_reference_number { Faker::Number.number(12) }
    creditor_account_number { Faker::Number.number(18) }

    payment_method { 1 }
    approval_reference_number { Faker::Number.number(12) }
    payment_number { Faker::Number.number(3) }
    transfer_amount { Faker::Number.decimal(10, 4) }
    account_city { Faker::Address.city }
    currency_date { Date.today }
    payment_date { Date.today }
  end
end

