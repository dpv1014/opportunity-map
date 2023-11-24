class IndicatorTracking < ApplicationRecord
  belongs_to :indicator

  after_save :calc_progress
  after_destroy :calc_progress

  def calc_progress
    indicator.calc_progress
  end
end
