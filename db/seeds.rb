require 'faker'

# Clear all data (for dev only)
User.destroy_all
Post.destroy_all
Comment.destroy_all
Follow.destroy_all
Like.destroy_all

# Create 5 users
puts "Creating users..."
users = 5.times.map do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: 'password', # Devise hashes it
    # avatar: nil # Set up later if using Active Storage or Cloudinary
  )
end

# Create 10 posts (2 per user)
puts "Creating posts..."
posts = users.flat_map do |user|
  2.times.map do
    Post.create!(
      content: Faker::Lorem.paragraph(sentence_count: 3),
      user: user
    )
  end
end

# Create 20 comments (random user and post)
puts "Creating comments..."
20.times do
  Comment.create!(
    content: Faker::Lorem.sentence(word_count: 8),
    user: users.sample,
    post: posts.sample
  )
end

# Create follows (each user follows 2 others, no self-following)
puts "Creating follow relationships..."
users.each do |follower|
  followees = users.reject { |u| u == follower }.sample(2)
  followees.each do |followed|
    Follow.find_or_create_by!(follower: follower, followed: followed)
  end
end

# Create likes (each user likes 3 random posts)
puts "Creating likes..."
users.each do |user|
  posts.sample(3).each do |post|
    Like.find_or_create_by!(user: user, post: post)
  end
end

puts "✅ Seed complete!"
