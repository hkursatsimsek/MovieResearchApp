//
//  ImageviewDownloader.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 14.03.2022.
//

import Foundation
import Kingfisher

class ImageviewDownloader: UIImageView {
    func getImage(urlString: String, placeholder: UIImage? = nil) {
        if let url = URL(string: urlString) {
            let processor = DownsamplingImageProcessor(size: self.frame.size)
            self.kf.indicatorType = .activity
            if self.kf.indicator != nil {
                if (self.kf.indicator!.view as? UIActivityIndicatorView) != nil {
                    (self.kf.indicator!.view as? UIActivityIndicatorView)!.color = .white
                }
            }
            self.kf.setImage( 
                with: url,
                placeholder: placeholder,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.none),
                    .cacheOriginalImage,
                    .transition(.fade(0.2))
                ], completionHandler:  {
                    result in
                    switch result {
                    case .success(let value):
                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                })
        } else {
            self.image = placeholder
        }
    }
}
