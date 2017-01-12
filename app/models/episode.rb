class Episode < ApplicationRecord
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
    fatigue: nil,
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

  def start_date
    self.start_date_time.to_date
  end

  def end_date
    self.end_date_time.to_date
  end
end
