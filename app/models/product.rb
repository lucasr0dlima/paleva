class Product < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :portions
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :menu_items

  validates :name, :description, :status, presence: true

  enum :status, {:active=>0, :inactive=>5}

  def all_tags
    self.tags.map(&:name).join(", ")
  end
end