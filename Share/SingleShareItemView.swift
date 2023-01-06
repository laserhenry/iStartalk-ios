//
//  SingleShareView.swift
//  Share
//
//  Created by busylei on 2022/12/15.
//  Copyright © 2022 QIM. All rights reserved.
//

import UIKit

class SingleShareItemView: BaseShareItemView {
    

    override var imageViewContentMode: UIView.ContentMode {
        .scaleAspectFit
    }
    
    override var playSize: CGFloat{
        50
    }
    
    override func setup() {
        super.setup()
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    
    override func addFileView(name: String){
        let image: UIImage
        image = UIImage(named: "File")!
        let icon = UIImageView(image: image)
        addSubview(icon)
        let iconLayout = UILayoutGuide()
        addLayoutGuide(iconLayout)
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconLayout.topAnchor.constraint(equalTo: topAnchor),
            iconLayout.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconLayout.bottomAnchor.constraint(equalTo: bottomAnchor),
            iconLayout.widthAnchor.constraint(equalTo: iconLayout.heightAnchor),
            icon.widthAnchor.constraint(equalToConstant: 50),
            icon.heightAnchor.constraint(equalToConstant: 50),
            icon.centerXAnchor.constraint(equalTo: iconLayout.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: iconLayout.centerYAnchor),
        ])
        

        let description = UILabel()
        description.text = name
        description.lineBreakMode = .byTruncatingMiddle
        addSubview(description)
        description.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            description.leadingAnchor.constraint(equalTo: iconLayout.trailingAnchor, constant: 20),
            description.trailingAnchor.constraint(equalTo: trailingAnchor),
            description.topAnchor.constraint(equalTo: topAnchor),
            description.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    var iamgeAspectRatio: CGFloat{
        if type == .image || type == .movie{
            let image: UIImage
            if type == .image{
                image = self.image!
            }else{
                image = self.movieImage!
            }
            let size = image.size
            if size.width > 0{
                return size.height / size.width
            }
        }
        return 0
    }
    
    var imageMaxHeight: CGFloat{
        300
    }
    
    var fileViewHeight: CGFloat{
        80
    }
}
