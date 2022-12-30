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
    var name: String = ""
    
    var image: UIImage?
    var movie: AVAsset?{
        didSet{
            if let movie = movie {
                movieImage = makeImage(movie: movie)
            }
        }
    }
    var file: Data?

    var movieImage: UIImage?
    
    func setup(){
        switch type{
        case .image:
            addImageView(image: image!)
        case .movie:
            addMovieView(movie: movie!, cover: movieImage!)
        case .file:
            addFileView(name: name)
        }
    }
    
    func addImageView(image: UIImage){
        let imageView = UIImageView(image: image)
        imageView.contentMode = imageViewContentMode
        imageView.clipsToBounds = true
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
        addImageView(image: cover)
        let playImage = UIImage(named: "Play")!.withRenderingMode(.alwaysTemplate)
        let playView = UIImageView(image: playImage)
        playView.tintColor = .white
        playView.alpha = 0.8
        addSubview(playView)
        playView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playView.widthAnchor.constraint(equalToConstant: playSize),
            playView.heightAnchor.constraint(equalToConstant: playSize),
            playView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])

        let duration = movie.duration
        let durationPresentation = getDurationPresentation(duration)
        let durationLabel = UILabel()
        durationLabel.text = durationPresentation
        durationLabel.font = .systemFont(ofSize: 12)
        durationLabel.textColor = .white
        addSubview(durationLabel)
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            durationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            durationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
    }
    
    var playSize: CGFloat{
        0
    }
    
    func addFileView(name:String){
        
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
    
    func getDurationPresentation(_ time: CMTime) -> String{
        let total = Int(time.seconds.rounded())
        let hours = total / 3600
        let minutes = (total % 3600) / 60
        let seconds = total % 60
        let presentation: String
        if hours > 0 {
            presentation = "\(hours):\(minutes):\(seconds)"
        }else{
            presentation = "\(minutes):\(seconds)"
        }
        return presentation
    }
}
