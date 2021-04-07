import Foundation

enum PostErrors: Error {
    case notFound
    case locked
    case imageNotLoaded
}

struct PostLoad {
    static func openPost() throws -> Post {
        throw PostErrors.notFound
        return Post(title: "Пост")
    }
}
