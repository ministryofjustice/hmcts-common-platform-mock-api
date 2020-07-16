# frozen_string_literal: true

class LjaDetails < ApplicationRecord
  validates :ljaCode, presence: true
  validates :ljaName, presence: true

  def to_builder
    Jbuilder.new do |lja_details|
      lja_details.ljaCode ljaCode
      lja_details.ljaName ljaName
      lja_details.welshLjaName welshLjaName
    end
  end
end
