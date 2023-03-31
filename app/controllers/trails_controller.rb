class TrailsController < ApplicationController
  def index
    @forest = Forest.find(params[:forest_id])
    @trails = @forest.trails.all

    render json: @trails
  end

  def show
    @forest = Forest.find(params[:forest_id])
    @trail = @forest.trails.find_by(id: params[:id])

    render json: @trail
  end

  def create
    @trail = Trail.create(name: params[:name], miles: params[:miles])
    @trail.forest = Forest.find(params[:forest_id])

    if @trail.save
      render json: @trail, status: :created
    else
      render json: { errors: @trail.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @trail = Trail.find(params[:id])
    @trail.forest = Forest.find(params[:forest_id])
    @trail.update(name: params[:name], miles: params[:miles])

    render json: "#{@trail.name} has been updated!"
  end

  def destroy
    @trail = Trail.find(params[:id])
    @trail.forest =Forest.find(params[:forest_id])
    @trail.destroy

    render json: "#{@trail.name} has been deleted!"
  end
end
