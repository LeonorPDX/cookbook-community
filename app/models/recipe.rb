class Recipe < ActiveRecord::Base
    validates_presence_of :name, :ingredients, :directions, :type_tag
    belongs_to :user
    has_many :saved_recipes
    has_many :users, through: :saved_recipes
end