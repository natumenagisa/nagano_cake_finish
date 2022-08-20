class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items
  has_many :order_items
  belongs_to :genre
  has_many :orders

  def with_tax_price
    (price * 1.1).floor
  end

end