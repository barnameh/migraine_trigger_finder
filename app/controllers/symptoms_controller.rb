class SymptomsController < ApplicationController
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

  def show
  end

  def new
    @symptom = Symptom.new()
    @symptom.user_id = 99
    @symptom.user_symptoms = COMMON_SYPTOMS.dup
    #binding.pry
    @symptom.user_symptoms["nausea"] = "on"
  end

  def create
    @symptom = Symptom.new()
    @symptom.user_id = 99
    #symptom_params
    #@symptom.user_symptoms = params[:user_symptoms]
    @symptom.user_symptoms = symptom_params
    start_date_time_params
    @symptom.start_date_time = Time.new(params[:symptom]["start_date_time(1i)"],
                                        params[:symptom]["start_date_time(2i)"],
                                        params[:symptom]["start_date_time(3i)"],
                                        params[:symptom]["start_date_time(4i)"],
                                        params[:symptom]["start_date_time(5i)"])

    binding.pry

    if @symptom.save
      # link_to ??
    else
      render :new
    end
  end

  private

  def symptom_params
    params.require(:user_symptoms).permit!
  end

  def start_date_time_params
    params.require(:symptom).permit(:start_date_time)
  end
end
