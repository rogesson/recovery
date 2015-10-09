class Category < ActiveRecord::Base
  self.table_name = "categories"

  attr_accessible :title

  validates :title, presence: true
  
  def created_at_formatted
    created_at.strftime("%d/%m/%Y")
  end
end
