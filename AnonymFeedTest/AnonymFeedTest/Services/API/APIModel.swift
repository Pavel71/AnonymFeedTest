// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let data: WelcomeData
}

// MARK: - WelcomeData
struct WelcomeData: Codable {
    let items: [Item]
    let cursor: String
}

// MARK: - Item
struct Item: Codable {
    let id: String
    let isCreatedByPage: Bool?
    let videoElementID: JSONNull?
    let status: Status
    let type: ItemType
    let coordinates: Coordinates?
    let isCommentable, hasAdultContent, isAuthorHidden, isHiddenInProfile: Bool
    let contents: [Content]
    let language: Language
    let awards: Awards
    let createdAt, updatedAt: Int
    let isSecret: Bool
    let page: JSONNull?
    let author: Author?
    let stats: Stats
    let isMyFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case id, isCreatedByPage
        case videoElementID = "videoElementId"
        case status, type, coordinates, isCommentable, hasAdultContent, isAuthorHidden, isHiddenInProfile, contents, language, awards, createdAt, updatedAt, isSecret, page, author, stats, isMyFavorite
    }
}

// MARK: - Author
struct Author: Codable {
    let id: String
    let url: URLEnum?
    let name: String
    let banner: Photo?
    let photo: Photo
    let gender: Gender
    let isHidden, isBlocked, allowNewSubscribers, showSubscriptions: Bool
    let showSubscribers, isMessagingAllowed: Bool
    let auth: Auth
    let statistics: Statistics
    let tagline: String
    let data: AuthorData
    let photoSpecialStyle, photoSpecialVariant, nameSpecialStyle: Int?
}

// MARK: - Auth
struct Auth: Codable {
    let isDisabled: Bool
    let lastSeenAt, level: Int
}

// MARK: - Photo
struct Photo: Codable {
    let type: PhotoType
    let id: String
    let data: PhotoData
}

// MARK: - PhotoData
struct PhotoData: Codable {
    let extraSmall, small: ExtraLarge
    let medium, large: ExtraLarge?
    let original: ExtraLarge
    let extraLarge: ExtraLarge?
}

// MARK: - ExtraLarge
struct ExtraLarge: Codable {
    let url: String
    let size: Size
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
}

enum PhotoType: String, Codable {
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
    case unset = "UNSET"
}

// MARK: - Statistics
struct Statistics: Codable {
    let likes: Int
    let thanks: Double
    let uniqueName: Bool
    let thanksNextLevel, subscribersCount, subscriptionsCount: Int
}

enum URLEnum: String, Codable {
    case jeditones = "jeditones"
    case jonathanl = "jonathanl"
}

// MARK: - Awards
struct Awards: Codable {
    let recent, statistics: [JSONAny]
    let voices: Int
    let awardedByMe: Bool
}

// MARK: - Content
struct Content: Codable {
    let data: ContentData
    let type: PhotoType
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
    let type: PhotoType
    let id: String
    let data: PreviewImageData
}

// MARK: - PreviewImageData
struct PreviewImageData: Codable {
    let extraSmall, medium: ExtraLarge
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Double
    let zoom: JSONNull?
}

enum Language: String, Codable {
    case en = "en"
    case ru = "ru"
}

// MARK: - Stats
struct Stats: Codable {
    let likes, views, comments, shares: Comments
    let replies: Comments
    let timeLeftToSpace: TimeLeftToSpace
}

// MARK: - Comments
struct Comments: Codable {
    let count: Int
    let my: Bool
}

// MARK: - TimeLeftToSpace
struct TimeLeftToSpace: Codable {
    let count: Int?
    let maxCount: JSONNull?
    let my: Bool
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

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
