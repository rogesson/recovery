class Category < ActiveRecord::Base
  self.table_name = "categories"

  def created_at_formatted
    created_at.strftime("%d/%m/%Y")
  end
end
