require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe '#valid?' do
    it 'false when name is empty' do
      tag = Tag.new

      tag.valid?
  
      expect(tag.errors).to include :name  
    end
  end
end
