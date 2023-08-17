struct ImageData: Codable {
    let id: String
    let url: String
    let width: Double
    let height: Double

    enum CodingKeys: String, CodingKey {
        case id
        case url = "download_url"
        case width
        case height
    }
}
