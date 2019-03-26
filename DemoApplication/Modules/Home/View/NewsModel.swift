import UIKit

class NewsModel: NSObject {
    var urlToImage: String
    var author: String
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case urlToImage
        case author
        case content
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(urlToImage, forKey: .urlToImage)
        try container.encode(author, forKey: .author)
        try container.encode(content, forKey: .content)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        urlToImage = try container.decode(String.self, forKey: .urlToImage)
        author = try container.decode(String.self, forKey: .author)
        content = try container.decode(String.self, forKey: .content)
    }
}

//struct NewsModel: Decodable {
//    var urlToImage:String
//    var author:String
//    var content:String
//}
