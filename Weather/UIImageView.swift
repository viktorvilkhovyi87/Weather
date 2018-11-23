//
//  UIImageView.swift
//  Weather
//
//  Created by Viktor Vilkhovyi on 11/20/18.
//  Copyright © 2018 Viktor Vilkhovyi. All rights reserved.
//

import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

class ImageView: UIImageView {
    
    private var imageUrl: String?
    
    private let session = URLSession(configuration: .default)
    
    func load(_ urlString: String?) {
        
        self.imageUrl = urlString
        
        guard let imageUrl = urlString, let url = URL(string: imageUrl) else {
            return
        }
        
        if let image = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = image
            self.contentMode = .scaleAspectFill
            return
        }
        
        session.dataTask(with: url) { [weak self] data, response, error in guard let this = self else {return}
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data)  {
                    imageCache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                    
                    if this.imageUrl == urlString {
                        this.image = downloadedImage
                        this.contentMode = .scaleAspectFill
                    }
                }
            }}.resume()
    }
}
