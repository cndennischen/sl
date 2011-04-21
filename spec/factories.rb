# Define factories for creating database records during tests

Factory.define :user do |f|
  f.sequence(:name) { |n| "user_#{n}" }
  f.sequence(:email) { |n| "user.#{n}@example.com" }
  f.provider "google"
  f.sequence(:uid) { |n| "uid_#{n}" }
end

Factory.define :sketch do |f|
  f.sequence(:name) { |n| "Sketch #{n}" }
  f.content "{}"
  f.association :user
end

Factory.define :faq do |f|
  f.sequence(:question) { |n| "Question #{n}" }
  f.sequence(:answer) { |n| "Answer #{n}" }
end
