class LjaDetail < ApplicationRecord
  validates :lja_name, presence: true
  validates :lja_code, presence: true

  def to_builder
    Jbuilder.new do |lja_detail|
      lja_detail.ljaCode lja_code
      lja_detail.ljaName lja_name
      lja_detail.welshLjaName welsh_lja_name
    end
  end
end
