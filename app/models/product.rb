class Product < ActiveRecord::Base
  has_many :line_items
  # Hook method; Rails calls automatically at a given point in an object's life
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

  # Returns the most recently updated product
  def self.latest
    Product.order(:updated_at).last
  end

  private

  # This method will be called before Rails attempts to destroy a row in the db
  # Ensures that no line items reference a given product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present') # error is associated w. base object
      return false
    end
  end

end
