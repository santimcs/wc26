class CriteriaController < ApplicationController
  before_action :set_criterium, only: [:show, :edit, :update, :destroy]

  def index
    @criteria = Criterium.all.order(:show_date)
  end

  def show
  end

  def new
    @criterium = Criterium.new
  end

  def edit
  end

  def create
    @criterium = Criterium.new(criterium_params)
    if @criterium.save
      redirect_to @criterium, notice: 'Criterium was successfully created.'
    else
      render :new
    end
  end

  def update
    if @criterium.update(criterium_params)
      redirect_to @criterium, notice: 'Criterium was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @criterium.destroy
    redirect_to criteria_url, notice: 'Criterium was successfully destroyed.'
  end

  private

  def set_criterium
    @criterium = Criterium.find(params[:id])
  end

  def criterium_params
    params.require(:criterium).permit(:show_date)
  end
end