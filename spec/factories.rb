Factory.define :user do |u|
  u.sequence(:email) {|n| "address#{n}@test.com"}
  u.password 'password'
  u.password_confirmation 'password'
  u.confirmed_at Time.now
end