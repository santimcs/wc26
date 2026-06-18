class FixturesController < ApplicationController
  before_action :set_fixture, only: [:show, :edit, :update, :destroy]

  def index
    @fixtures = Fixture.includes(:round, :session, :home_team, :away_team, :channel).order(:date, :session_id)
  end

  def show
  end

  def new
    @fixture = Fixture.new
  end

  def edit
  end

  def create
    @fixture = Fixture.new(fixture_params)
    if @fixture.save
      redirect_to @fixture, notice: 'Fixture was successfully created.'
    else
      render :new
    end
  end

  def update
    if @fixture.update(fixture_params)
      redirect_to @fixture, notice: 'Fixture was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @fixture.destroy
    redirect_to fixtures_path, notice: 'Fixture was successfully destroyed.'
  end

  def list_fixtures
    # Use the first criterium or a specific one as default
    @criterium = Criterium.first
    @fixtures = Fixture.includes(:round, :session, :home_team, :away_team, :channel)
                       .where("date >= ?", @criterium&.show_date || Date.today)
                       .order(:date, :session_id)
  end

  private

  def set_fixture
    @fixture = Fixture.find(params[:id])
  end

  def fixture_params
    params.require(:fixture).permit(:round_id, :date, :session_id, :home_team_id, :away_team_id, :channel_id, :criterium_id)
  end
  
end