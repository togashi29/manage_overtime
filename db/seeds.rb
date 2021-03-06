# user
GROUPS = ["A", "B", "C", "D", "E"].freeze
PASSWORD = "password".freeze
NUMBER_OF_USERS_PER_GROUP = 3

number_of_groups = GROUPS.length
number_of_users = NUMBER_OF_USERS_PER_GROUP * number_of_groups

users = []
# ゲスト
users << {
  name: "ゲスト",
  group: "G",
  email: "guest@email.com",
  password: PASSWORD,
}

# ゲスト以外
(1..number_of_users).each do |i|
  group_index = i % number_of_groups - 1
  users << {
    name: Gimei.unique.name.kanji,
    group: GROUPS[group_index],
    email: "user_id_#{i}@email.com",
    password: PASSWORD,
  }
end

User.create!(users)
puts "テストユーザーの初期データを投入しました"

# overtime
# データの入力期間
YEARS = 1
START_DATE = Date.today - (YEARS * 12).months
END_DATE = Date.today

# 記録する時刻の範囲
WORK_START_TIME = Tod::TimeOfDay.parse("17:15")
# => #<Tod::TimeOfDay:0x00007f8bc84accb0 @hour=17, @minute=15, @second=0, @second_of_day=62100>
MIN_WORK_END_TIME = Tod::TimeOfDay.parse("17:16")
MIN_WORK_END_TIME_MINUTE = MIN_WORK_END_TIME.second_of_day / 60
MAX_WORK_END_TIME = Tod::TimeOfDay.parse("24:00")
MAX_WORK_END_TIME_MINUTE = MAX_WORK_END_TIME.second_of_day / 60

# 入力確率 1/rand(RECORD_CONSTANT_RANGE) の確率でデータを記録
RECORD_CONSTANT_RANGE = (3..6).freeze

overtimes = []
users = User.order("id")
# 全ユーザーの内、最後のユーザーを除くユーザー
users.slice(0, users.length - 1).each do |user|
  record_constant = rand(RECORD_CONSTANT_RANGE)
  (START_DATE..END_DATE).each do |date|
    next unless rand(record_constant).zero?

    work_end_time = Tod::TimeOfDay.new(0) + rand(MIN_WORK_END_TIME_MINUTE..MAX_WORK_END_TIME_MINUTE) * 60
    overtimes << {
      user_id: user.id,
      date: date,
      work_start_time: WORK_START_TIME.to_s,
      work_end_time: work_end_time.to_s,
      work_time: (work_end_time - WORK_START_TIME).to_s,
    }
  end
end

# 最後のユーザー
user = users.last
record_constant = rand(RECORD_CONSTANT_RANGE)
(START_DATE..END_DATE).each do |date|
  next if date.month.odd?
  next unless rand(record_constant).zero?

  work_end_time = Tod::TimeOfDay.new(0) + rand(MIN_WORK_END_TIME_MINUTE..MAX_WORK_END_TIME_MINUTE) * 60
  overtimes << {
    user_id: user.id,
    date: date,
    work_start_time: WORK_START_TIME.to_s,
    work_end_time: work_end_time.to_s,
    work_time: (work_end_time - WORK_START_TIME).to_s,
  }
end

Overtime.create!(overtimes)
puts "残業日時の初期データを投入しました。"

# request
DETAIL_1 = "水田作付作物の現地確認に、私の代役で行ってもらいたいです。".freeze
DETAIL_2 = "園芸産地づくり事業のポンチ絵作成を手伝ってほしいです。".freeze
DETAIL_3 = "機械導入補助事業の完成確認検査に、私の代役で行ってもらいたいです。".freeze
User.find_by(name: "ゲスト").requests.create!(detail: DETAIL_1)
User.second.requests.create!(detail: DETAIL_2)
User.third.requests.create!(detail: DETAIL_3)
puts "頼みたい事の初期データを投入しました。"
