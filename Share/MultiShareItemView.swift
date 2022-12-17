//
//  MultiShareView.swift
//  Share
//
//  Created by busylei on 2022/12/15.
//  Copyright © 2022 QIM. All rights reserved.
//

import UIKit

class MultiShareItemView: BaseShareItemView {

    override var imageViewContentMode: UIView.ContentMode {
        .scaleAspectFill
    }
    
    override var playSize: CGFloat{
        30
    }
}
