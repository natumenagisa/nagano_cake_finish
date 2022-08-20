class OrderDetail < ApplicationRecord
  belongs_to :item
  enum making_status: { "製作不可":0, "製作待ち":1, "制作中":2, "制作完了":3 }
end
