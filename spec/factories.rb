Factory.define :user do |u|
  u.sequence(:email) {|n| "address#{n}@test.com"}
  u.password 'secret'
  u.password_confirmation 'secret'
  u.confirmed_at Time.now
  u.time_zone 'Rome'
end

Factory.define :auction do |a|
  a.sequence(:url) {|n| "http://ebay.com/items/1234#{n}"}
  a.sequence :item_id do |n|
    id = "12345678901#{n}"
    id.size > 12 ? id[(id.size - 12)..-1] : id
  end
  a.end_time 1.day.from_now
  a.sequence(:title) {|n| "An auction title #{n}"}
  a.association :seller, :factory => :ebayer
end

Factory.define :ebayer do |s|
  s.sequence(:name) {|n| "Seller #{n}"}
end