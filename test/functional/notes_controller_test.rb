require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  setup do
    @user = users(:rogesson)
  end

  test 'should get index' do
    login_as(:rogesson)
    get :index

    assert_response :success
    assert_template 'index'
    assert_present assigns(:notes_result)
  end

  test 'should create note' do
    login_as(:rogesson)
    note_params = { 
                    note: {
                      title: 'My Title',
                      body: 'My body',
                      category_id: category.to_param
                    }
                  }

    assert_difference('Note.count') do
      post :create, note_params
    end

    assert_equal "success", assigns(:response)
  end

  test 'should not create note' do
    login_as(:rogesson)
    note_params = { 
                          note: {
                            title: 'Title only'
                          }
                        }

    assert_no_difference('Note.count') do
      post :create, note_params
    end
  end

  test 'should update note' do
    login_as(:rogesson)
    put :update, id: notes(:phone_number).to_param, note: { body: '(11) 92831222' }

    assert_equal "success", assigns(:response)
  end

  test 'should destroy note' do
    login_as(:rogesson)
    
    assert_difference('Note.count', -1) do
      delete :destroy, id: notes(:phone_number).to_param
    end
    assert_equal "success", assigns(:response)
  end

  private

  def category
    categories(:study)
  end
end