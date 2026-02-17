class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :product_category
  belongs_to :product_type

  scope :active, -> { where(active: true) }
  extend FriendlyId
  friendly_id :random_code, use: :slugged

  after_save :update_signature
  after_commit :enqueue_resize_image, on: [ :create, :update ]

  def enqueue_resize_image
    return unless image.attached?
    return if image.blob.metadata["resized"] == true

    ResizeProductImageJob.perform_later(self)
  end

  def update_signature
    return unless signature
    return unless saved_change_to_signature?

    Product.where.not(id: id).update_all(signature: false)
  end

  def random_code
    SecureRandom.hex(4)
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
