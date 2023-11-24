class Indicator < ApplicationRecord

  enum indicator_type: [:incremental, :reduction]
  has_many :indicator_trackings, dependent: :destroy

  after_save :calc_progress

  def self.dashboard_url(dashboard = 1)
    payload = {
      :resource => {:dashboard => dashboard},
      :params => { },
      :exp => Time.now.to_i + (60 * 10) # 10 minute expiration
    }
    token = JWT.encode payload, ENV["METABASE_SECRET_KEY"]

    ENV["METABASE_SITE_URL"] + "/embed/dashboard/" + token + "#bordered=true&titled=true"
  end

  def self.translate_indicator_type_enum
    {"incremental"=> "Incremental", "reduction"=>"Reducción"}
  end

  def calc_progress
    case indicator_type
    when "incremental"
      calc_incremental
    when "reduction"
      calc_reduction
    end
  end

  def calc_incremental
    return 0 if indicator_trackings.size.zero?

    calc_base_line = base_linea.to_f
    cal_target_value = target_value.to_f

    out = indicator_trackings.map do |period|
      (period&.value).to_f
    end.sum.to_f

    out = out / (cal_target_value - calc_base_line) * 100

    update_columns(progress_percentage: out)
    out
  end

  def calc_reduction
    return 0 if indicator_trackings.size.zero?

    calc_base_line = base_linea.to_f
    cal_target_value = target_value.to_f

    period = indicator_trackings.last
    if !period&.value.blank?
      out = (period&.value).to_f
      out = (calc_base_line.to_f - out) / (calc_base_line.to_f - cal_target_value.to_f) * 100
    else
      out = 0
    end

    update_columns(progress_percentage: out)
    out
  end

end
