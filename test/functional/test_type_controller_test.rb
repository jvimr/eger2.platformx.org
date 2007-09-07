require File.dirname(__FILE__) + '/../test_helper'
require 'test_type_controller'

# Re-raise errors caught by the controller.
class TestTypeController; def rescue_action(e) raise e end; end

class TestTypeControllerTest < Test::Unit::TestCase
  fixtures :test_types

  def setup
    @controller = TestTypeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = test_types(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:test_types)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:test_type)
    assert assigns(:test_type).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:test_type)
  end

  def test_create
    num_test_types = TestType.count

    post :create, :test_type => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_test_types + 1, TestType.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:test_type)
    assert assigns(:test_type).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      TestType.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      TestType.find(@first_id)
    }
  end
end
