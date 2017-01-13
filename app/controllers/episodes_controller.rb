class EpisodesController < ApplicationController
  def index
    @episodes = Episode.where(user_id: current_user.id)
    @episodes_by_date = @episodes.group_by(&:start_date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def new
    @episode = Episode.new()
    @episode.user_id = current_user.id
    @episode.symptoms = Episode::COMMON_SYPTOMS.dup
    @episode.triggers = Episode::COMMON_TRIGGERS.dup
  end

  def create
    @episode = Episode.new(episode_params)
    @episode.user_id = current_user.id
    @episode.symptoms = symptoms_params
    @episode.triggers = triggers_params
    if @episode.save
      redirect_to episode_path(@episode.id)
    else
      render :new
    end
  end

  def show
    @episode = Episode.find(params["id"])
  end

  def edit
    @episode = Episode.find(params["id"])
    @episode.symptoms = Episode::COMMON_SYPTOMS.merge(@episode.symptoms)
    @episode.triggers = Episode::COMMON_TRIGGERS.merge(@episode.triggers)
  end

  def update
    @episode = Episode.find(params["id"])
    @episode.symptoms = symptoms_params
    @episode.triggers = triggers_params
    if @episode.update(episode_params)
      redirect_to episode_path(@episode.id)
    else
      render :edit
    end
  end

  def destroy
    Episode.find(params["id"]).destroy
    redirect_to episodes_path
  end

  private

  def episode_params
    params.require(:episode).permit(:intensity, :start_date_time, :end_date_time)
  end

  def symptoms_params
    if params[:symptoms]
      params.require(:symptoms).permit!
    else
      {}
    end
  end

  def triggers_params
    if params[:triggers]
      params.require(:triggers).permit!
    else
      {}
    end
  end
end
