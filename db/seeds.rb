@raw_text = "Buddies are [mainly] Russian students currently studying at HSE University, who are voluntarily helping international incoming students to get accustomed to life in Moscow and feel more confident in a new cultural and social environment through assisting them in their basic needs. You meet your buddy upon your arrival or can request their help any time throughout your stay. The buddies usually meet the international tudents at the Aeroexpress terminal, accompany them to the dormitory and help with the check-in procedures, provide them with general hands-on experience, help with documents and forms in Russian, recommend interesting places and events in the city and direct them to the person in charge in case the international student's question requires the involvement of the university administration. It is importnt to remember that buddies are just student volunteers, so they are not obliged to become international students' full time personal assistants or provide any financial support. Therefore, please, respect buddies' personal time and space. If you have further questions or want to join the organisation, contact ISN HSE Moscow via email"
@words = @raw_text.downcase.gsub(/[—.—,«»:()]/, '').gsub(/  /, ' ').split(' ')

def seed 
	reset_db
	create_users(10)
	create_discussions(20)
	create_posts(20)
	create_comments(20)

	3.times do
		create_comment_replies
	end
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

	first_names = ["John", "Jane", "Alex", "Emily", "Michael", "Jiho", "Chan", "Chris", "Mark", "Sophia", "Nilufer", "Aydana", "Yeji", "Paulina", "Felix", "Miguel"]
	surnames = ["Yildiz", "Johnson", "Williams", "Brown", "Kim", "Kang", "Ali", "Zhang", "Martinez", "Hernandez", "Abdusattorov", "Lee", "Miyawaki", "Acar", "Abay", "Wang"]
	faculties = ["Факультет математики", "Факультет экономических наук", "Московский институт электроники и математики им. А.Н. Тихонова", "Факультет компьютерных наук", "Высшая школа бизнеса", "Высшая школа юриспруденции и администрирования", "Факультет гуманитарных наук", "Факультет социальных наук", "Факультет креативных индустрий", "Факультет мировой экономики и мировой политики", "Факультет физики", "Международный институт экономики и финансов", "Факультет городского и регионального развития", "Факультет химии", "Факультет биологии и биотехнологии", "Факультет географии и геоинформационных технологий", "Школа иностранных языков", "Институт статистических исследований и экономики знаний", "Банковский институт", "Школа инноватики и предпринимательства"]
	program_types = ["Студент полной степени обучения", "Студент по обмену", "Студент программы подготовки"]

	admin = User.create!(email: 'admin@edu.hse.ru', password: 'password', admin: true, user_role: 'admin')
	puts "Admin created with email: #{admin.email}"

	10.times do |i|
		begin
			student_name = "#{first_names.sample} #{surnames.sample}"
			student = User.create!(
				email: "student_#{i}@edu.hse.ru",
				password: 'password',
				user_role: 'international_student'
			)
			student_profile = Profile.create!(
				user: student,
				name: student_name,
				date_of_birth: Date.new(rand(1989..2005), rand(1..12), rand(1..28)),
				gender: ['М', 'Ж'].sample,
				country: ["Russia", "USA", "China", "India", "Germany", "France", "Japan"].sample,
				faculty: faculties.sample,
				languages: ["English", "Russian", "Chinese", "French", "Spanish"].sample(2).join(", "),
				program_type: program_types.sample
			)
			puts "International student created with email: #{student.email}"

			create_application_forms(student) if student.persisted?

			buddy_name = "#{first_names.sample} #{surnames.sample}"
			buddy = User.create!(
				email: "buddy_#{i}@edu.hse.ru",
				password: 'password',
				user_role: 'buddy'
			)
			buddy_profile = Profile.create!(
				user: buddy,
				name: buddy_name,
				date_of_birth: Date.new(rand(1989..2005), rand(1..12), rand(1..28)),
				gender: ['М', 'Ж'].sample,
				country: ["Russia", "USA", "China", "India", "Germany", "France", "Japan"].sample,
				faculty: faculties.sample,
				languages: ["English", "Russian", "Chinese", "French", "Spanish"].sample(2).join(", "),
				program_type: "Студент полной степени обучения"
			)
			puts "Buddy created with email: #{buddy.email}"
		rescue ActiveRecord::RecordInvalid => e
			puts "Error creating record for #{student_name || buddy_name}: #{e.message}"
			puts "Validation errors: #{e.record.errors.inspect}"
			e.record.errors.each do |field, messages|
				if messages.present? # Check if messages is not nil or empty
					puts "#{field}: #{messages.join(', ')}"
				else
					puts "#{field}: No error message available"
				end
			end
		end
	end
end

def create_application_forms(user)

	puts "User exists: #{User.exists?(id: user.id)}, User ID: #{user.id}"

	arrival_places = [
    'Аэропорт Шереметьево', 'Аэропорт Домодедово', 'Аэропорт Внуково', 
    'Казанский вокзал', 'Ленинградский вокзал', 'Курский вокзал', 
    'Киевский вокзал', 'Савёловский вокзал', 'Ярославский вокзал', 
    'Белорусский вокзал', 'Павелецкий вокзал', 'Рижский вокзал', 'Восточный вокзал'
	]

	residence_places = [
    'Общежитие №1', 'Общежитие №2', 'Общежитие №3', 'Общежитие №4', 
    'Общежитие №5', 'Общежитие №6', 'Общежитие №7', 'Общежитие №8', 
    'Общежитие №9', 'Общежитие №10', 'Другое'
	]

	application_form_data = {
		student_id: user.id,
		about: create_sentence,
		date_of_arrival: Date.today + rand(1..30).days,
		time_of_arrival: Time.now + rand(1..10).hours,
		place_of_arrival: arrival_places.sample,
		place_of_residence: residence_places.sample,
		note: [create_sentence, nil].sample
	}

	application_form = ApplicationForm.create!(application_form_data)
	puts "Application form created for user_id #{user.id} with id #{application_form.id}"
end

def create_posts(quantity)

	all_info = {
		"Адаптационная встреча: для кого и зачем?" => ["Первая встреча с однокурсниками — это важный шаг для социализации", "ОБУЧЕНИЕ"],
		"Лучшие места для коворка в Москве" => ["Иногда учиться вне дома бывает полезным, мы составили список лучших мест для коворкинга", "БЫТ"],
		"Какие документы нужны для учебы в России" => ["Иностранцы, поступающие в Россию, должны знать о необходимых документах для учебы", "ДОКУМЕНТЫ"],
		"Как выбрать и где оформить мед. страховку?" => ["Медицинская страховка — это обязательная вещь для каждого иностранца", "ДОКУМЕНТЫ"],
		"Как справляться с ностальгией: советы по адаптации" => ["Чувство ностальгии знакомо каждому иностранному студенту, мы подскажем, как бороться с ним", "БЫТ"],
		"Какие места посетить в Москве иностранцу в первую очередь?" => ["В Москве много туристических мест, посещение которых поможет вам погрузиться", "КУЛЬТУРА"],
		"Как выбрать и снять жилье иностранцу?" => ["Пошаговое руководство по поиску жилья, включая советы по аренде и описание особенностей", "БЫТ"],
		"Как оформить банковскую карту и какой банк выбрать?" => ["Иностранные карты в России не работают, поэтому для безналичной оплаты необходимо оформить", "БЫТ"],
		"Какие льготы есть для студентов в Москве?" => ["Для студентов во многих музеях и магазинах есть скидки и льготы, сегодня мы поговорим", "КУЛЬТУРА"]
	}

	headlines = all_info.keys
	tags = ['быт', 'учёба', 'культура', 'документы']

	quantity.times do
		user = User.all.sample
		title = headlines.sample
		content = all_info[title]
		description_content = content.length > 50 ? "#{content[0...50]}..." : content
		post = Post.create(
			title: headlines.sample, 
			content: description_content,
			user: user,
			tag: tags.sample
			)
		post_image = upload_random_image(post, :post_image)
		post.post_image = post_image
		post.save!
		puts "Post with id #{post.id} just created"
	end
end

def create_discussions(quantity)

	all_info = {
		"Кто идёт на адаптационную встречу?" => ["28 августа будет адаптационная встреча, кто-нибудь значет, что там будет?", "УЧЁБА"],
		"Музей русского импрессионизма — топ!!" => ["Сегодня сходили туда на выставку, нам очень понравилось!! Всем рекомендую", "КУЛЬТУРА"],
		"Как оформить справку в бассейн?" => ["Кто-нибудь ходил в бассейн ВШЭ? Я знаю, что туда нужна справка, как её можно получить?", "ДОКУМЕНТЫ"],
		"Где погулять в Москве?" => ["Хочется погулять по нестандартным туристическим маршрутам, может кто-то что-то подскажет", "КУЛЬТУРА"],
		"Какими приложениями такси вы пользуетесь?" => ["Скоро приезжаю в Россию, какое приложение для вызова такси стоит скачать?", "БЫТ"],
		"Есть ли у кого-то опыт перевода в другую группу?" => ["Хочу перевестись, кому нужно писать по этому поводу? Вообще возможно ли это?", "УЧЁБА"],
		"Альтернативное размещение" => ["Есть ли кто-то, кто живёт не в общежитии Вышки? Хочу кое-что спросить", "ДОКУМЕНТЫ"],
		"В каком банке вы открывали карту?" => ["Только приехала в Москву, надо открыть карту, а я не знаю, какую выбрать. Поделитесь опытом", "БЫТ"],
		"Халяль кухня в Москве" => ["Поделитесь местами с хорошей халяль едой в Москве, пожалуйста", "БЫТ"]
	}

	headlines = all_info.keys
	tags = ['быт', 'учёба', 'культура', 'документы']

	quantity.times do
		user = User.all.sample
		title = headlines.sample
		content = all_info[title]
		description_content = content.length > 50 ? "#{content[0...50]}..." : content
		discussion = Discussion.create(
			title: headlines.sample, 
			content: description_content,
			user: user,
			tag: tags.sample
			)
		discussion.save!
		puts "Discussion with id #{discussion.id} just created"
	end
end

def create_comments(quantity)
	Post.all.each do |post|
		rand(1..quantity).times do
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
		rand(1..quantity).times do
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

def create_comment_replies
	Comment.all.each do |comment|
		if rand(1..3) == 1
			comment_reply = comment.replies.create!(
				parent_comment_id: comment.id,
				commentable: comment.commentable, 
				user: User.all.sample,
				body: create_sentence
				)
			puts "Comment reply with id #{comment_reply.id} for discussion with id #{comment.id} just created"
		end
	end
end

seed