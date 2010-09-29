Factory.define :user do |u|
  u.sequence(:email) {|n| "address#{n}@test.com"}
  u.password 'password'
  u.password_confirmation 'password'
  u.confirmed_at Time.now
end

Factory.define :auction do |a|
  a.sequence(:url) {|n| "http://ebay.com/items/1234#{n}"}
  a.sequence(:item_id) {|n| "1234#{n}"}
  a.end_time 1.day.from_now
  a.sequence(:title) {|n| "An auction title #{n}"}
end