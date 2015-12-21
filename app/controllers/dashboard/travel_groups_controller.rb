class Dashboard::TravelGroupsController < ApplicationController

  def create; end

  def update;  end

  def destroy;  end

  def travel_group_params
    params.require(:travel_group).permit!
  end
end
