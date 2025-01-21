class CreateAddress < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street # Rua
      t.string :cep # CEP
      t.string :state # Estado
      t.string :city # Cidade
      t.string :bairro # Bairro
      t.string :complemento # Complemento
      t.integer :number # Number

      t.timestamps
    end
  end
end
