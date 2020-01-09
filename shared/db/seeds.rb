# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.delete_all
Product.create! JSON.parse(File.read('db/seeds/product.json'))

Variant.delete_all
Variant.create! JSON.parse(File.read('db/seeds/product-variants.json'))

OptionValue.delete_all
OptionValue.create! JSON.parse(File.read('db/seeds/product-variants-option-values.json'))

OptionValuesVariant.delete_all
OptionValuesVariant.create! JSON.parse(File.read('db/seeds/product-variants-option-values-variants.json'))
