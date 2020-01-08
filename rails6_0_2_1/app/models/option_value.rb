class OptionValue < ActiveRecord::Base
  has_many :option_values_variants, dependent: :destroy
  has_many :variants, through: :option_values_variants
end
