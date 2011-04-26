Factory.sequence :email do |n|
  "email#{n}@mlm.com"
end

Factory.define :user do |f|
  f.first_name "Christopher"
  f.last_name "Fortenberry"
  f.email { Factory.next(:email) }
  f.password "secret"
end

Factory.define :instructor do |f|
  f.user :user
end

# Factory.define :user_with_instructor, :parent => :user do |user|
#   user.after_create { |a| Factory(:instructor, :user => a) }
# end