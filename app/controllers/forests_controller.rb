class ForestsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @forests = Forest.all

    if @forests.any?
      render json: @forests
    else
      render json: { error: 'Forests not found' }, status: :not_found
    end
  end

  def show
    @forest = Forest.find(params[:id])

    render json: @forest
  end

  def create
    @forest = Forest.create(forest_params)

    if @forest.save
      render json: @forest, status: :created
    else
      render json: @forest.errors, status: :unprocessable_entity
    end
  end

  def update
    @forest = Forest.find(params[:id])
    if @forest.update(forest_params)
      render json: "#{@forest.name} has been updated!"
    else
      render json: @forest.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @forest = Forest.find(params[:id])
    @forest.destroy

    render json: "#{@forest.name} has been deleted!"
  end

  private

  def forest_params
    # params.permit(:name, :state)
    params.require(:forest).permit(:name, :state)
  end

  def not_found
    render json: { error: 'Forest not found' }, status: :not_found
  end
end
