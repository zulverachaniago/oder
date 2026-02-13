# Resize gambar produk setelah upload (max 1200px sisi terpanjang, jaga aspect ratio).
# Mengurangi ukuran file dan mencegah "size too large" di production.
# Memerlukan ImageMagick (sudo apt install imagemagick / brew install imagemagick).
class ResizeProductImageJob < ApplicationJob
  queue_as :default

  MAX_DIMENSION = 1200

  discard_on ActiveJob::DeserializationError

  def perform(product)
    return unless product.image.attached?

    blob = product.image.blob
    return if blob.metadata["resized"] == true

    resize_and_replace(product, blob)
  end

  private

  def resize_and_replace(product, blob)
    blob.open do |tmp|
      resized = ImageProcessing::MiniMagick
        .source(tmp)
        .resize_to_limit(MAX_DIMENSION, MAX_DIMENSION)
        .call

      next unless resized && File.exist?(resized.path)

      product.image.purge
      File.open(resized.path) do |io|
        product.image.attach(
          io: io,
          filename: blob.filename.to_s,
          content_type: blob.content_type,
          metadata: blob.metadata.merge("resized" => true)
        )
      end
    end
  rescue => e
    Rails.logger.warn "[ResizeProductImageJob] Skip resize for product #{product.id}: #{e.message}"
  end
end
