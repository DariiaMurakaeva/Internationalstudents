@raw_text = "Buddies are [mainly] Russian students currently studying at HSE University, who are voluntarily helping international incoming students to get accustomed to life in Moscow and feel more confident in a new cultural and social environment through assisting them in their basic needs. You meet your buddy upon your arrival or can request their help any time throughout your stay. The buddies usually meet the international tudents at the Aeroexpress terminal, accompany them to the dormitory and help with the check-in procedures, provide them with general hands-on experience, help with documents and forms in Russian, recommend interesting places and events in the city and direct them to the person in charge in case the international student's question requires the involvement of the university administration. It is importnt to remember that buddies are just student volunteers, so they are not obliged to become international students' full time personal assistants or provide any financial support. Therefore, please, respect buddies' personal time and space. If you have further questions or want to join the organisation, contact ISN HSE Moscow via email"
@words = @raw_text.downcase.gsub(/[—.—,«»:()]/, '').gsub(/  /, ' ').split(' ')

def seed 
	reset_db
	create_users(10)
	create_discussions(20)
	create_posts(20)
	create_comments(2..8)
end

def reset_db
	Rake::Task['db:drop'].invoke
	Rake::Task['db:create'].invoke
	Rake::Task['db:migrate'].invoke
end

def create_sentence
	sentence_words = []

	(10..20).to_a.sample.times do
		sentence_words << @words.sample
	end

	sentence = sentence_words.join(' ').capitalize + '.'
end

def upload_random_image(record, attachment_field)
	uploader = PostImageUploader.new(record, attachment_field)
	uploader.cache!(File.open(Dir.glob(File.join(Rails.root, 'public/autoupload', record.class.to_s.downcase.pluralize, '*')).sample))
	uploader
end

def create_users(quantity)
	i = 0

	quantity.times do
		user_data = {
			email: "user_#{i}@email.com",
			password: 'testtest'
		}

		if i == 0 
			user_data[:admin] = true
		end 	

		user = User.create!(user_data)
		puts "User created with id #{user.id}"

		i += 1
	end
end


def create_posts(quantity)
	quantity.times do
		user = User.all.sample
		post = Post.create(
			title: create_sentence, 
			content: create_sentence,
			tags: "tag#{rand(1..5)}",
			user: user
			)
		post_image = upload_random_image(post, :post_image)
		post.post_image = post_image
		post.save!
		puts "Post with id #{post.id} just created"
	end
end

def create_discussions(quantity)
	quantity.times do
		user = User.all.sample
		discussion = Discussion.create(
			title: create_sentence, 
			content: create_sentence,
			tags: "tag#{rand(1..5)}",
			user: user
			)
		discussion_image = upload_random_image(discussion, :discussion_image)
		discussion.discussion_image = discussion_image
		discussion.save!
		puts "Discussion with id #{discussion.id} just created"
	end
end

def create_comments(quantity)
	Post.all.each do |post|
		quantity.to_a.sample.times do
			user = User.all.sample
			comment = Comment.create(
				commentable: post, 
				body: create_sentence,
				user: user
				)
			puts "Comment with id #{comment.id} for post with id #{comment.commentable.id} just created"
			end
	end
	Discussion.all.each do |discussion|
		quantity.to_a.sample.times do
			user = User.all.sample
			comment = Comment.create(
				commentable: discussion,
				body: create_sentence,
				user: user
				)
			puts "Comment with id #{comment.id} for discussion with id #{comment.commentable.id} just created"
		end
	end
end

seed