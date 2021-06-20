// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let data: WelcomeData?
}

// MARK: - WelcomeData
struct WelcomeData: Codable {
    let items: [Item]?
    let cursor: String?
}

// MARK: - Item
struct Item: Codable {
    let id: String?
    let isCreatedByPage: Bool?
    let videoElementID: JSONNull?
    let status: Status?
    let type: ItemType?
    let coordinates: Coordinates?
    let isCommentable, hasAdultContent, isAuthorHidden, isHiddenInProfile: Bool?
    let contents: [Content]?
    let language: Language?
    let awards: Awards?
    let createdAt, updatedAt: Int?
    let isSecret: Bool?
    let page: JSONNull?
    let author: Author?
    let stats: Stats?
    let isMyFavorite: Bool?

    enum CodingKeys: String, CodingKey {
        case id, isCreatedByPage
        case videoElementID = "videoElementId"
        case status, type, coordinates, isCommentable, hasAdultContent, isAuthorHidden, isHiddenInProfile, contents, language, awards, createdAt, updatedAt, isSecret, page, author, stats, isMyFavorite
    }
}

// MARK: - Author
struct Author: Codable {
    let id: String?
    let url: String?
    let name: String?
    let banner, photo: Banner?
    let gender: Gender?
    let isHidden, isBlocked, allowNewSubscribers, showSubscriptions: Bool?
    let showSubscribers, isMessagingAllowed: Bool?
    let auth: Auth?
    let statistics: Statistics?
    let tagline: String?
    let data: AuthorData?
    let photoSpecialStyle, photoSpecialVariant, nameSpecialStyle: Int?
}

// MARK: - Auth
struct Auth: Codable {
    let isDisabled: Bool?
    let lastSeenAt, level: Int?
}

// MARK: - Banner
struct Banner: Codable {
    let type: BannerType?
    let id: String?
    let data: BannerData?
}

// MARK: - BannerData
struct BannerData: Codable {
    let extraSmall, small, medium, large: ExtraLarge?
    let original, extraLarge: ExtraLarge?
}

// MARK: - ExtraLarge
struct ExtraLarge: Codable {
    let url: String?
    let size: Size?
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int?
}

enum BannerType: String, Codable {
    case audio = "AUDIO"
    case image = "IMAGE"
    case imageGIF = "IMAGE_GIF"
    case tags = "TAGS"
    case text = "TEXT"
    case video = "VIDEO"
}

// MARK: - AuthorData
struct AuthorData: Codable {
}

enum Gender: String, Codable {
    case male = "MALE"
    case other = "OTHER"
    case unset = "UNSET"
}

// MARK: - Statistics
struct Statistics: Codable {
    let likes: Int?
    let thanks: Double?
    let uniqueName: Bool?
    let thanksNextLevel, subscribersCount, subscriptionsCount: Int?
}

// MARK: - Awards
struct Awards: Codable {
    let recent: [String]?
    let statistics: [Statistic]?
    let voices: Double?
    let awardedByMe: Bool?
}

// MARK: - Statistic
struct Statistic: Codable {
    let id: String?
    let count: Int?
}

// MARK: - Content
struct Content: Codable {
    let data: ContentData?
    let type: BannerType?
    let id: String?
}

// MARK: - ContentData
struct ContentData: Codable {
    let value: String?
    let extraSmall, small, medium, large: ExtraLarge?
    let extraLarge, original: ExtraLarge?
    let duration: Double?
    let url: String?
    let size: Size?
    let previewImage: PreviewImage?
    let values: [String]?
}

// MARK: - PreviewImage
struct PreviewImage: Codable {
    let type: BannerType?
    let id: String?
    let data: PreviewImageData?
}

// MARK: - PreviewImageData
struct PreviewImageData: Codable {
    let extraSmall, medium: ExtraLarge?
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Double?
    let zoom: Int?
}

enum Language: String, Codable {
    case en = "en"
    case ru = "ru"
}

// MARK: - Stats
struct Stats: Codable {
    let likes, views, comments, shares: Comments?
    let replies: Comments?
    let timeLeftToSpace: TimeLeftToSpace?
}

// MARK: - Comments
struct Comments: Codable {
    let count: Int?
    let my: Bool?
}

// MARK: - TimeLeftToSpace
struct TimeLeftToSpace: Codable {
    let count: Int?
    let maxCount: JSONNull?
    let my: Bool?
}

enum Status: String, Codable {
    case published = "PUBLISHED"
}

enum ItemType: String, Codable {
    case audioCover = "AUDIO_COVER"
    case plain = "PLAIN"
    case plainCover = "PLAIN_COVER"
    case video = "VIDEO"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
