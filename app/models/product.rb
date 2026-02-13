class Product < ApplicationRecord
    has_one_attached :image
    belongs_to :product_category
    belongs_to :product_type
    extend FriendlyId
    friendly_id :random_code, use: :slugged
    
    def random_code
        SecureRandom.hex(4) # Menghasilkan 8 karakter (misal: "a1b2c3d4")
    end

    def should_generate_new_friendly_id?
        slug.blank?
    end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "name", "price", "product_category_id", "product_type_id", "slug", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["product_category", "product_type"]
   end

end
