raise 'Seeding is reserved for development' unless Rails.env.development?

puts 'Creating users...'
users = FactoryBot.create_list(:user, 100)

puts 'Creating functions...'
functions = users.map do |user|
  FactoryBot.create_list(:function, 10, user: user)
end.flatten

puts 'Creating likes...'
users.sample(50).each do |user|
  functions.sample(30).each do |function|
    FactoryBot.create(:like, user: user, likeable: function)
  end
end

puts 'Creating saves...'
users.sample(50).each do |user|
  functions.sample(30).each do |function|
    FactoryBot.create(:save, user: user, function: function)
  end
end

puts 'Creating comments...'
users.sample(50).each do |user|
  functions.sample(30).each do |function|
    FactoryBot.create(:comment, user: user, function: function)
  end
end
