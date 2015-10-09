require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  test 'should create note' do
    assert user.note.create(title: 'list of books', body: 'book 1, book 2', category_id: category.id)
  end

  test 'should get note' do
    note_id = user.note.first.id

    assert_nothing_raised { Note.find(note_id) }
  end

  test 'should update note' do
    assert user.note.first.update_attributes(title: 'another title', body: 'another body')
  end

  test 'should destroy credential' do
    note = user.note.first
    note.destroy

    assert_raise(ActiveRecord::RecordNotFound) { Note.find(note.id) }
  end

  test 'should validate attributes' do
    note = Note.new

    assert !note.valid?
    assert note.errors[:title].any?
    assert note.errors[:body].any?
    assert note.errors[:category_id].any?

    assert_equal ["can't be blank"], note.errors[:title]
    assert_equal ["can't be blank"], note.errors[:body]
    assert_equal ["is not a number"], note.errors[:category_id]
  end

  test 'should get short title' do
    note = user.note.first
    note.title = 'Looooooooooooooooooooooooooooooooooooooooooooooong Title'
    note.save

    assert_equal 'Looooooooo...', note.short_title
  end

  test 'should decrypt body' do
    note = Note.first
    note.update_attributes(body: 'secret body')

    assert_equal 'secret body', note.unsafe_body
  end

  private

  def user
    users(:rogesson)
  end

  def category
    categories(:study)
  end
end
