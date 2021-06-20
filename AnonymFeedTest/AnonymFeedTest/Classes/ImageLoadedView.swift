//
//  ImageLoadedView.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 19.06.2021.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class ImageLoadedView: UIImageView {
    var imageUrlString: String?

    func downloadImageFrom(withUrl urlString : String) {
        imageUrlString = urlString

        guard let url = URL(string: urlString) else { return }
        image = nil

        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else { return }
           

            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else { return }
                    if self.imageUrlString == urlString {
                        self.image = image
                    }
                imageCache.setObject(image, forKey: urlString as NSString)
            }
        }).resume()
    }
    
    func downloadImageGifFrom(withUrl urlString : String, completion: @escaping (UIImage?) -> Void) {
        imageUrlString = urlString

        guard let url = URL(string: urlString) else { return }
        image = nil

        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            
            guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
                print("image doesn't exist")
                completion(nil)
                return
            }
            RunLoop.main.perform(inModes: [.common]) {
                let image = UIImage.animatedImageWithSource(source: source) ?? UIImage()
                imageCache.setObject(image, forKey: urlString as NSString)
                completion(image)
            }
            
            
        }).resume()
    }
}
