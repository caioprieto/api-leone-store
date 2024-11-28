# rails dev:setup

require 'faker'

namespace :dev do

  DEFAULT_PASSWORD = 123321

  NUMBER_PRODUCTS = 15

  desc "Configura o Ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando DB...") { %x(rails db:drop) }
      show_spinner("Criando DB...") { %x(rails db:create) }
      show_spinner("Migrando DB...") { %x(rails db:migrate) }
      show_spinner("Cadastrando categoria...") { %x{rails dev:add_categories} }
      show_spinner("Cadastrando #{NUMBER_PRODUCTS} produtos...") { %x(rails dev:add_products) }
    else
      puts "Você não está no ambiente de desenvolvimento"
    end
  end

  task add_categories: :environment do
    Category.create!(
      name: 'DVDs'
    )
  end

  task add_products: :environment do
    NUMBER_PRODUCTS.times do
      Product.create!(
        name: Faker::Commerce.product_name,
        category_id: ::Category.last.id,
        barcode: Faker::Barcode.ean(13),
        code: Faker::Number.unique.between(from: 10, to: 1000),
        preço_final: Faker::Number.between(from: 100, to: 300)
      )
    end
  end

  private

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
