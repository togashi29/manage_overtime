class Overtime < ApplicationRecord
  belongs_to :user
  attr_accessor :work_time
  before_validation :convert_work_time_to_work_time_minute
  validates :date, presence: true, uniqueness: { scope: :user_id }
  validates :work_start_time, presence: true
  validates :work_end_time, presence: true
  validates :work_time_minute, presence: true, numericality: { greater_than: 0 }
  validate :end_time_later_than_start_time?

  # index-chart用
  def self.group_monthly_hour_data
    # {["A", "2019年4月"]=>1828, ["A", "2019年5月"]=>6418, ...} を生成
    group_monthly_minute_data = Overtime.joins(:user).select("overtimes*, users*").group("users.group").group("DATE_FORMAT(date,'%Y年%c月')").sum(:work_time_minute)
    hash = {}
    group_monthly_minute_data.each do |key, value|
      hash[key] = (value.to_f / 60).floor(1)
    end
    hash
  end

  def self.group_monthly_chart_data
    # {"A"=> {"2019年4月"=>30.4, "2019年5月"=>106.9, ...} に成形
    hash = Hash.new {|h, k| h[k] = {} }
    Overtime.group_monthly_hour_data.each do |key, value|
      hash[key[0]][key[1]] = value
    end
    hash
  end

  def end_time_later_than_start_time?
    if self.work_start_time.present? && self.work_end_time.present?
      if self.work_start_time > self.work_end_time
        self.errors.add(:work_start_time, " > 終了時刻となっています。")
      end
    end
  end

  private

    def convert_work_time_to_work_time_minute
      self.work_time_minute = begin
                                Tod::TimeOfDay.parse(self.work_time).to_i / 60
                              rescue
                                0
                              end
    end
end
