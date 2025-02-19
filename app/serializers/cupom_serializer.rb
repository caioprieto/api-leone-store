class CupomSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_date, :final_date, :desconto
end
