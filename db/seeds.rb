User.destroy_all

30.times do |i|
	user = User.new
	user.email = "user#{i}@mail.com"
	user.name = "name #{i}"
	user.password = "password"
  user.password_confirmation = "password"
	user.phone = "08238423234#{i}"
	user.facebook_url = nil
	user.twitter_url = nil
	user.youtube_url = nil
	user.admin = nil
	user.save
end

User.last(5).map { |u| u.update(facebook_url:"https://www.facebook.com/")  }
User.first(5).map { |u| u.update(twitter_url:"https://www.twitter.com/")  }
User.first(10).last(5).map { |u| u.update(youtube_url:"https://www.youtube.com/")  }
User.last(20).map { |u| u.update(phone:nil)  }

2.times do |i|
	user = User.new
	user.email = "admin#{i}@mail.com"
	user.name = "name #{i}"
	user.password = "password"
  user.password_confirmation = "password"
	user.facebook_url = nil
	user.twitter_url = nil
	user.youtube_url = nil
	user.admin = true
	user.save
end
