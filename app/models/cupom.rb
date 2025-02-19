class Cupom < ApplicationRecord
  has_many :carts, class_name: '::Cart'

  validate :start_date_cant_grater_final_date
  validate :start_date_not_equal_final_date

  private

  def start_date_cant_grater_final_date
    if start_date > final_date
      errors.add(:error, "Data de ínicio não pode ser maior que Data final")
      false
    end
  end

  def start_date_not_equal_final_date
    if start_date.to_date == final_date.to_date
      errors.add(:error, "Data de ínicio não pode ser igual a Data final")
      false
    end
  end
end
