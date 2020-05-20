class User < ActiveRecord::Base
    validates_presence_of :username, :email
    validates_uniqueness_of :username, :email
    has_secure_password
    has_many :recipes
    has_many :saved_recipes
    has_many :recipes, through: :saved_recipes

    def slug
        self.username.gsub("_", "-").downcase
      end
    
    def self.find_by_slug(slug)
        self.all.find{ |user| user.slug == slug }
    end

    def valid_username?
      nil if self.class.find_by_slug(self.username)
    end

end