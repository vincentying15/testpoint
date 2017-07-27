class TestCasesController < ApplicationController
  before_action { @navbar = "cases" }
  load_and_authorize_resource :component
  load_and_authorize_resource

  def index
    @components = Component.all
    @test_cases = @test_cases.where(component_id: @component) if @component.present?
    @test_cases = @test_cases.page(params[:page])
  end

  def new
  end

  def create
    @test_case.save

    respond_with @test_case
  end

  def show
  end

  def edit
  end

  def update
    @test_case.update(test_case_params)

    respond_with @test_case
  end

protected

  def test_case_params
    params.fetch(:test_case, {}).permit(:title, :content, :component_id)
  end
end
