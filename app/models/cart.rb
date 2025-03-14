class Cart < ApplicationRecord
  belongs_to :user, class_name: '::User', optional: true
  belongs_to :cupom, class_name: '::Cupom', optional: true

  has_many :cart_products, class_name: '::CartProduct', dependent: :destroy, inverse_of: :cart
  has_many :products, through: :cart_products

  has_one :order, class_name: '::Order'

  validate :not_change_cupom

  accepts_nested_attributes_for :cart_products, allow_destroy: true

  before_validation :calculate_values
  before_validation :remove_product_without_quantity

  def calculate_values
    add_cupom
    calculate_subtotal
    calculate_total
  end

  def calculate_subtotal
    value_total = 0

    cart_products.each do |cart_product|
      value_total += cart_product.product.preço_final * cart_product.quantidade_produto_carrinho
    end

    self.subtotal = value_total
  end

  def remove_product_without_quantity
    cart_products.where(quantidade_produto_carrinho: 0).destroy_all
  end

  def add_cupom
    return self.cupom_value = 0 if cupom.blank? || cupom.start_date > Time.zone.now || cupom.final_date < Time.zone.now

    self.cupom_value = cupom.desconto
  end

  def calculate_total
    self.total = subtotal - cupom_value
  end

  def not_change_cupom
    errors.add(:base, "Não é possível adicionar outro cupom") if cupom_id_changed? && cupom_id_was.present?
  end
end
