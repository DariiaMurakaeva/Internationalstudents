posts = [
{
	name: "Polina",
	title: "Собираем документы",
	tags: "документы",
	content: "Скоро расскажем, как собрать документы для переезда и обучения в России"
},
{
	name: "Nariyaana",
	title: "Как заселиться в общежитие",
	tags: "жильё",
	content: "Скоро расскажем, как заселиться в общежитие без проблем"
},
{
	name: "Dariya",
	title: "Что взять с собой в Россию",
	tags: "сбор вещей",
	content: "Скоро расскажем, что из вещей стоит взять с собой перед отъездом"
}
]
posts.each do |post|
    p = Post.create(post)
    puts "Some magic just created a post with title #{ p.name } with id #{ p.id }!"
end

discussions = [
{
	name: "Jiho",
	title: "HELP WITH THE TRANSLATION",
	tags: "русский язык",
	content: "Where do I get the official translation of the passport??"
},
{
	name: "Mark",
	title: "Need help with the bank card",
	tags: "документы",
	content: "I forgot most of my cash and I need to urgently open a bank account. Please, give me some advice which bank should I choose?"
}
]
discussions.each do |discussion|
    d = Discussion.create(discussion)
    puts "Some magic just created a discussion with title #{ d.name } with id #{ d.id }!"
end