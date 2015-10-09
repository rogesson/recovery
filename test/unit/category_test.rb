require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test 'should create category' do
    assert Category.create(title: 'Music')
  end

  test 'should update category' do
    assert category.update_attributes(title: 'Series')
  end

  test 'should destroy category' do
    category.destroy

    assert_raise(ActiveRecord::RecordNotFound) { Category.find(category.id) }
  end

  test 'should validate attributes' do
    new_category = Category.new

    assert !new_category.valid?
    assert new_category.errors[:title].any?

    assert_equal ["can't be blank"], new_category.errors[:title]
  end

  private

  def category
    categories(:study)
  end
end
