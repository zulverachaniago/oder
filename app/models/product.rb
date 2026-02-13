class Product < ApplicationRecord
    has_one_attached :image
    belongs_to :product_category
    belongs_to :product_type
    extend FriendlyId
    friendly_id :random_code, use: :slugged

    after_save :update_signature

    def update_signature
      return unless signature
      return unless saved_change_to_signature?

      # Hanya satu produk yang boleh jadi signature: unset yang lain
      Product.where.not(id: id).update_all(signature: false)
    end
    
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
