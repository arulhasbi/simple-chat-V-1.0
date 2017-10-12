//
//  ViewDesign.swift
//  simple-chat
//
//  Created by Arul on 10/10/17.
//  Copyright © 2017 69 Rising. All rights reserved.
//

import UIKit

@IBDesignable
class ViewDesign: UIView {

    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
