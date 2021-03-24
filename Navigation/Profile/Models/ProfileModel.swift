struct ProfilePost {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
    let imageStack: [String]
    
    
    init(author: String = "", description: String = "", image: String = "", likes: Int = 0, views: Int = 0, imageStack: [String] = []) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
        self.imageStack = imageStack
    }
}

struct ProfileModel {
    let posts = [
        [
            ProfilePost(imageStack: ["cat1", "cat2", "cat3", "cat4"])
        ],
        [
            ProfilePost(author: "Британские кот-ученые", description: "Внезапно! На Луне обнаружены мыши! Мир в опасности.", image: "cat scientist", likes: 534, views: 676),
            ProfilePost(author: "НацКотГеогр общество", description: "Созданы когти нового поколения. Если гора не идет к коту, кот идет по горе", image: "cat climber", likes: 333, views: 432),
            ProfilePost(author: "НеСобаки водолазы", description: "Кот - собрат научился смотреть под водой. Будущее рядом!", image: "cat waterfowl", likes: 666, views: 777),
            ProfilePost(author: "THT", description: "Новый сезон Танцы на ТНТ!", image: "cat dance", likes: 421, views: 1000)
        ]
    ]
}
