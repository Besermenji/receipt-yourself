class CreateInputInvoiceClosures < ActiveRecord::Migration
  def change
    create_table :input_invoice_closures do |t|
      t.datetime :closure_date, null: false
      t.decimal :closure_amount, null: false, precision: 15, scale: 4

      t.belongs_to :daily_statement, index: true
      t.belongs_to :input_invoice, index: true

      t.timestamps null: false
    end
  end
end
