//
//  ShareItem.swift
//  Share
//
//  Created by busylei on 2022/12/23.
//  Copyright © 2022 QIM. All rights reserved.
//

import UIKit
import AVFoundation

enum ShareType: String{
    case image
    case movie
    case file
}

struct ShareFile{
    var name: String
    var data: Data
}

struct ShareItem{
    var type: ShareType
    var url: URL
    var image: UIImage?
    var movie: AVAsset?
    var file: ShareFile?
}
