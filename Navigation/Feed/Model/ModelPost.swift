struct ModelPost {
    let author: String
    let description: String
    let image: String
    var likes: Int
    var views: Int
}

struct ProfilePosts {
    static let posts = [
        ModelPost(author: "Британские кот-ученые", description: "Внезапно! На Луне обнаружены мыши! Мир в опасности.", image: "cat scientist", likes: 534, views: 676),
        ModelPost(author: "НацКотГеогр общество", description: "Созданы когти нового поколения. Если гора не идет к коту, кот идет по горе", image: "cat climber", likes: 333, views: 432),
        ModelPost(author: "НеСобаки водолазы", description: "Кот - собрат научился смотреть под водой. Будущее рядом!", image: "cat waterfowl", likes: 666, views: 777),
        ModelPost(author: "THT", description: "Новый сезон Танцы на ТНТ!", image: "cat dance", likes: 421, views: 1000)
    ]
}
