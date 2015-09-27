module CategoriesHelper
  def self.options_for_select
      Category.all.flat_map{|category| [ [category.title, category.id] ] }.insert(0, 'Select')
  end
end
