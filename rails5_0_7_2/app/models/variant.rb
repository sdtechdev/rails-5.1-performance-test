class Variant < ActiveRecord::Base
  belongs_to :product
  has_many :option_values_variants
  has_many :option_values, through: :option_values_variants
end
