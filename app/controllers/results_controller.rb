class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]

  def index
    @results = Result.includes(fixture: [:home_team, :away_team]).order('fixtures.date DESC')
  end

  def show
  end

  def new
    @result = Result.new
    @result.fixture_id = params[:fixture_id] if params[:fixture_id].present?
    @fixtures = Fixture.includes(:home_team, :away_team)
                       .where.not(id: Result.pluck(:fixture_id))
                       .order(:date)
  end

  def edit
    @fixtures = Fixture.includes(:home_team, :away_team, :round).order(:date)
  end

  def create
    @result = Result.new(result_params)
    
    if @result.save
      redirect_to results_path, notice: 'Result was successfully created.'
    else
      @fixtures = Fixture.includes(:home_team, :away_team, :round)
                         .where.not(id: Result.pluck(:fixture_id))
                         .order(:date)
      render :new
    end
  end

  def update
    if @result.update(result_params)
      redirect_to results_path, notice: 'Result was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @result.destroy
    redirect_to results_path, notice: 'Result was successfully destroyed.'
  end

  private

  def set_result
    @result = Result.find(params[:id])
  end

  def result_params
    params.require(:result).permit(:fixture_id, :home_goals, :away_goals)
  end
end