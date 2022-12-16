//
//  ShareItemView.swift
//  Share
//
//  Created by busylei on 2022/12/15.
//  Copyright © 2022 QIM. All rights reserved.
//

import UIKit
import AVFoundation

class BaseShareItemView: UIView {
    var type: ShareType = .image
    
    var image: UIImage?
    var movie: AVAsset?{
        didSet{
            if let movie = movie {
                movieImage = makeImage(movie: movie)
            }
        }
    }
    var file: ShareFile?

    var movieImage: UIImage?
    
    func setup(){
        switch type{
        case .image, .movie:
            addImageView(image: image!)
        case .file:
            addFileView(file: file!)
        }
    }
    
    func addImageView(image: UIImage){
        let imageView = UIImageView(image: image)
        imageView.contentMode = imageViewContentMode
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    var imageViewContentMode: UIView.ContentMode {
        .redraw
    }
    
    func addMovieView(movie: AVAsset, cover: UIImage){
        
    }
    
    func addFileView(file: ShareFile){
        
    }
    
    
    func makeImage(movie: AVAsset) -> UIImage{
        let generator = AVAssetImageGenerator(asset: movie)
        let time = CMTimeMake(value: 0, timescale: 1)
        let cgImage = try? generator.copyCGImage(at: time, actualTime: nil)
        if let cgImage = cgImage{
            return UIImage(cgImage: cgImage)
        }else{
            return UIImage()
        }
    }
}
