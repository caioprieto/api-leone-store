require 'rails_helper'

RSpec.describe ::Cart, type: :model do
  it { is_expected.to have_many :cart_products }
  it { is_expected.to have_one :order }
end