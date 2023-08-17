import UIKit

final class MediumService {
    static let shared: MediumService = .init()
    private init() {}

    private(set) var media: [Medium] = []
    private(set) var loading: Bool = false

    func append(medium: Medium) {
        media.insert(medium, at: 0)
    }

    func load(progress: @escaping (Double) -> Void, completion: @escaping ([Medium]?) -> Void) {
        let decoder = JSONDecoder()
        guard let location = Bundle.main.url(forResource: "images", withExtension: "json"),
              let data = try? Data(contentsOf: location),
              let images = try? decoder.decode([ImageData].self, from: data) else { return completion(nil) }

        loading = true
        var media: [Medium] = []
        let dispatchGroup = DispatchGroup()
        var rate = (progress: 0, completion: images.count)
        images.enumerated().forEach { _, image in
            dispatchGroup.enter()
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: URL(string: image.url)!),
                      let uiImage = UIImage(data: data)
                else { return dispatchGroup.leave() }
                media.append(Medium(image: uiImage, width: image.width, height: image.height))
                dispatchGroup.leave()

                DispatchQueue.main.async {
                    progress(Double(rate.progress) / Double(rate.completion))
                    rate.progress += 1
                }
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.media = media
            self?.loading = false
            completion(media)
        }
    }

    func search() {}
}
