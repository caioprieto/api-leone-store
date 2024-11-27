ActiveRecord::Schema[7.0].define(version: 2024_11_27_172041) do
  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "cep"
    t.string "state"
    t.string "city"
    t.string "bairro"
    t.string "complemento"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_products", force: :cascade do |t|
    t.integer "cart_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantidade_produto_carrinho"
    t.index ["cart_id", "product_id"], name: "unique_cart_product_index", unique: true
    t.index ["cart_id"], name: "index_cart_products_on_cart_id"
    t.index ["product_id"], name: "index_cart_products_on_product_id"
  end

  create_table "carts", force: :cascade do |t|
    t.string "status", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active_view_index"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "barcode"
    t.string "code", null: false
    t.string "size"
    t.string "color"
    t.text "description"
    t.text "size_description"
    t.boolean "active", default: true, null: false
    t.integer "quantity", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id", null: false
    t.integer "cart_id"
    t.index ["cart_id"], name: "index_products_on_cart_id"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cart_products", "carts"
  add_foreign_key "cart_products", "products"
  add_foreign_key "carts", "users"
  add_foreign_key "products", "carts"
  add_foreign_key "products", "categories"
end
