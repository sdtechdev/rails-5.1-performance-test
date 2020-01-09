# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def import_json(model, json_file_name)
  model.delete_all
  column_names = model.column_names
  full_json = JSON.parse(File.read("db/seeds/#{json_file_name}.json"))
  model.create! full_json.map { |hash| hash.slice(*column_names) }
end
import_json Product, 'product'
import_json Variant, 'product-variants'
import_json OptionValue, 'product-variants-option-values'
import_json OptionValuesVariant, 'product-variants-option-values-variants'
