class ForestsController < ApplicationController
  def index
    @forests = Forest.all

    render json: @forests
  end

  def show
    @forest = Forest.find(params[:id])

    render json: @forest
  end

  def create
    @forest = Forest.create(name: params[:name], state: params[:state])

    render json: @forest
  end

  def update
    @forest = Forest.find(params[:id])
    @forest.update(name: params[:name], state: params[:state])

    render json: "#{@forest.name} has been updated!"
  end

  def destroy
    @forest = Forest.find(params[:id])
    @forest.destroy

    render json: "#{@forest.name} has been deleted!"
  end
end
