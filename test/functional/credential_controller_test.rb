require File.expand_path("../../test_helper", __FILE__)

class CredentialsControllerTest < ActionController::TestCase

  setup do
    @controller = CredentialsController.new

    @request.session[:user_id] = 1
    session[:session_id] = Random.rand(19999283)
    session[:c_key] = "aoskdopakspodkaspokdpaoskdpoaksd"
  end

  test "sound create credential" do
    post(:create, create_params)

    assert_equal @request.env["rack.session"]["flash"][:notice], 'Successfully created!'
  end

  test "should update credential" do
    put(:update, id: 44, :password => "newpass")
    
    assert_equal @response.body, { response: 'success' }.to_json
  end

  test "should delete credential" do
    delete(:destroy, id: 44)

    assert_equal @response.body, { response: 'success' }.to_json
  end

  private

  def create_params
    {
     "authenticity_token"=>"ZlSQnOw0x/zm/KqL+tIF5zWdEnd+gzEQaCoaAIw9r6s=",
     "credential"=>{
      "site"=>"somesite",
      "login"=>"somelogin",
      "password"=>"somepassword"
      },
    "commit"=>"Create Credential"
    }
  end
end
