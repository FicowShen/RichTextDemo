//
//  TextContainer.swift
//  RichTextDemo
//
//  Created by Ficow on 2019/11/24.
//  Copyright © 2019 ficow. All rights reserved.
//

import UIKit

class TextContainer: NSTextContainer {

    override var exclusionPaths: [UIBezierPath] {
        get {
            return super.exclusionPaths
        }
        set {
            super.exclusionPaths = newValue
        }
    }
}
