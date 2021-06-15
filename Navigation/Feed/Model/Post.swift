import Foundation

struct Post {
    
    let title: String
    
    static func map(_ data: Data) -> Post? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>,
           let title = json["title"] as? String {
            return Post(title: title)
        }
        return nil
    }
}
