import Foundation

enum PostErrors: Error {
    case notFound
    case locked
    case imageNotLoaded
}

enum ProfileErrors: Error {
    case missingText
}

struct PostLoad {
    static func openPost() throws -> Post {
        throw PostErrors.notFound
    }
}
