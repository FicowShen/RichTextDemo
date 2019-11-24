//
//  LayoutManager.swift
//  RichTextDemo
//
//  Created by Ficow on 2019/11/24.
//  Copyright © 2019 ficow. All rights reserved.
//

import UIKit

class LayoutManager: NSLayoutManager {
    
    override func processEditing(for textStorage: NSTextStorage, edited editMask: NSTextStorage.EditActions, range newCharRange: NSRange, changeInLength delta: Int, invalidatedRange invalidatedCharRange: NSRange) {
        super.processEditing(for: textStorage, edited: editMask, range: newCharRange, changeInLength: delta, invalidatedRange: invalidatedCharRange)
        printValues(textStorage, editMask, newCharRange, delta, invalidatedCharRange, endSymbol: "\n🌟🌟🌟🌟🌟\n")
    }
    
    override func setAttachmentSize(_ attachmentSize: CGSize, forGlyphRange glyphRange: NSRange) {
        super.setAttachmentSize(attachmentSize, forGlyphRange: glyphRange)
    }
    
    override func attachmentSize(forGlyphAt glyphIndex: Int) -> CGSize {
        return super.attachmentSize(forGlyphAt: glyphIndex)
    }
    
}
