raise 'Seeding is reserved for development' unless Rails.env.development?

logger = Logger.new(STDOUT)
logger.level = Logger::DEBUG

logger.info 'Creating users...'
users = FactoryBot.create_list(:user, 100)

logger.info 'Creating functions...'
functions = users.map do |user|
  FactoryBot.create_list(:function, 10, user: user, tags: [])
end.flatten

logger.info 'Creating tags...'
tags = 20.times
         .map { Faker::Hacker.adjective }
         .grep(/\A[\w\-]+\z/)
         .uniq
         .sample(10)
         .map { |tag_name| FactoryBot.create(:tag, name: tag_name) }
functions.each do |function|
  function.tags = tags.sample(3)
end

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
