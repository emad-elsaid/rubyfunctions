raise 'Seeding is reserved for development' unless Rails.env.development?

logger = Logger.new($stdout)
logger.level = Logger::DEBUG

logger.info 'Creating users...'
users = FactoryBot.create_list(:user, 100)

logger.info 'Creating functions...'

tags = 20.times.map { Faker::Hacker.adjective }.grep(/\A[\w\-]+\z/).uniq

functions = users.map do |user|
  FactoryBot.create_list(:function, 10, user: user, tags_list: tags.sample(3).join(','))
end.flatten

logger.info 'Creating likes...'
users.sample(50).each do |user|
  functions.sample(30).each do |function|
    FactoryBot.create(:like, user: user, likeable: function)
    FactoryBot.create(:notification, recipient: function.user, actor: user, notifiable: function)
  end
end

logger.info 'Creating saves...'
users.sample(50).each do |user|
  functions.sample(30).each do |function|
    FactoryBot.create(:save, user: user, function: function)
  end
end

logger.info 'Creating comments...'
users.sample(50).each do |user|
  functions.sample(30).each do |function|
    FactoryBot.create(:comment, user: user, function: function)
    FactoryBot.create(:notification, recipient: function.user, actor: user,
                                     notifiable: function, type: 'Notification::Commented')
  end
end
