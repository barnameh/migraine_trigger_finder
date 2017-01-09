class EpisodesController < ApplicationController
  COMMON_SYPTOMS ={
    pounding_pain: nil,
    pulsating_pain: nil,
    throubin_pain: nil,
    worse_pain_if_moving: nil,
    nausea: nil,
    vomiting: nil,
    sesitivity_to_light: nil,
    sensitivity_to_noise: nil,
    sensitivity_to_smell: nil,
    neck_pain: nil,
    giddiness: nil,
    nasal_congestion: nil,
    insomnia: nil,
    depressed_mood: nil,
    anxiety: nil,
    heat: nil,
    ringing_in_ear: nil,
    fatique: nil,
    blurred_vision: nil,
    moody: nil,
    diarrhea: nil,
    confusion: nil,
    light_headed: nil
  }

  COMMON_TRIGGERS = {
    stress: nil,
    lack_of_sleep: nil,
    too_much_sleep: nil,
    interrupted_sleep: nil,
    anxiety: nil,
    skipped_meal: nil,
    weather_change: nil,
    storm: nil,
    humidity: nil,
    neck_pain: nil,
    alcohol: nil,
    bright_sun: nil,
    dehydration: nil,
    caffeine: nil,
    processed_food: nil,
    allergy_reaction: nil,
    odd_or_strong_smell: nil,
    rebound_headache: nil,
    chocolate: nil,
    sinus: nil,
    aged_cheese: nil
  }

  def index
  end

  def new
    @episode = Episode.new()
    @episode.user_id = 99
    @episode.symptoms = COMMON_SYPTOMS.dup
    @episode.triggers = COMMON_TRIGGERS.dup
  end

  def create
    @episode = Episode.new()
    @episode.user_id = 99

    episode_params
    @episode.intensity = params[:episode][:intensity]
    @episode.start_date_time = Time.new(params[:episode]["start_date_time(1i)"],
                                        params[:episode]["start_date_time(2i)"],
                                        params[:episode]["start_date_time(3i)"],
                                        params[:episode]["start_date_time(4i)"],
                                        params[:episode]["start_date_time(5i)"])

    @episode.end_date_time = Time.new(params[:episode]["end_date_time(1i)"],
                                      params[:episode]["end_date_time(2i)"],
                                      params[:episode]["end_date_time(3i)"],
                                      params[:episode]["end_date_time(4i)"],
                                      params[:episode]["end_date_time(5i)"])

    @episode.symptoms = symptoms_params
    @episode.triggers = triggers_params
    binding.pry
    if @episode.save
      # link_to ??
    else
      render :new
    end
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def episode_params
    params.require(:episode).permit(:intensity, :start_date_time, :end_date_time)
  end

  def symptoms_params
    params.require(:symptoms).permit!
  end

  def triggers_params
    params.require(:triggers).permit!
  end
end
