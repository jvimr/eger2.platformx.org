require File.dirname(__FILE__) + '/../test_helper'
require 'test_page_controller'

# Re-raise errors caught by the controller.
class TestPageController; def rescue_action(e) raise e end; end

class TestPageControllerTest < Test::Unit::TestCase
  fixtures :test_pages

  def setup
    @controller = TestPageController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = test_pages(:first).id
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

    assert_not_nil assigns(:test_pages)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:test_page)
    assert assigns(:test_page).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:test_page)
  end

  def test_create
    num_test_pages = TestPage.count

    post :create, :test_page => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_test_pages + 1, TestPage.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:test_page)
    assert assigns(:test_page).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      TestPage.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      TestPage.find(@first_id)
    }
  end
end
