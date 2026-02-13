class ProductType < ApplicationRecord
    extend FriendlyId
    friendly_id :random_code, use: :slugged
    
    def random_code
        SecureRandom.hex(4) # Menghasilkan 8 karakter (misal: "a1b2c3d4")
    end

    def should_generate_new_friendly_id?
        slug.blank?
    end

    has_many :products
    belongs_to :product_category

    validates :name, presence: true, uniqueness: { scope: :product_category_id }

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "name", "slug", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["products", "product_category"]
    end
end
