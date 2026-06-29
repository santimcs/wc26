class KnockoutResultsController < ApplicationController
  before_action :set_knockout_result, only: [:show, :edit, :update, :destroy]
  before_action :set_knockout_fixtures, only: [:new, :edit, :create]

  # GET /knockout_results
  def index
    @knockout_results = KnockoutResult.joins(:fixture)
                                      .where(fixtures: { round_id: Round.where('sequence >= 2') })
                                      .order('fixtures.date, fixtures.session_id')
  end

  # GET /knockout_results/1
  def show
  end

  # GET /knockout_results/new
  def new
    @knockout_result = KnockoutResult.new
  end

  # GET /knockout_results/1/edit
  def edit
  end

  # POST /knockout_results
  def create
    @knockout_result = KnockoutResult.new(knockout_result_params)

    if @knockout_result.save
      redirect_to @knockout_result, notice: 'Knockout result was successfully created.'
    else
      set_knockout_fixtures
      render :new
    end
  end

  # PATCH/PUT /knockout_results/1
  def update
    if @knockout_result.update(knockout_result_params)
      redirect_to @knockout_result, notice: 'Knockout result was successfully updated.'
    else
      set_knockout_fixtures
      render :edit
    end
  end

  # DELETE /knockout_results/1
  def destroy
    @knockout_result.destroy
    redirect_to knockout_results_url, notice: 'Knockout result was successfully destroyed.'
  end

  private

  def set_knockout_result
    @knockout_result = KnockoutResult.find(params[:id])
  end

  def set_knockout_fixtures
    @fixtures = Fixture.joins(:round)
                       .where(rounds: { sequence: 2..6 })
                       .order(:date, :session_id)
                       .includes(:home_team, :away_team)
  end

  def knockout_result_params
    params.require(:knockout_result).permit(:fixture_id, :home_goals, :away_goals)
  end
end