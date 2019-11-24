//
//  TextStorage.swift
//  RichTextDemo
//
//  Created by Ficow on 2019/11/24.
//  Copyright © 2019 ficow. All rights reserved.
//

import UIKit

class TextStorage: NSTextStorage {
    
    let backingStore = NSMutableAttributedString()
    
    override var string: String {
        return backingStore.string
    }
    
    override func attributes(
        at location: Int,
        effectiveRange range: NSRangePointer?
    ) -> [NSAttributedString.Key: Any] {
        return backingStore.attributes(at: location, effectiveRange: range)
    }
    
    override func replaceCharacters(in range: NSRange, with str: String) {
        
        printValues(range, str, endSymbol: "\n🌟\n") // no <img> here
        beginEditing()
        backingStore.replaceCharacters(in: range, with:str)
        edited(.editedCharacters, range: range,
               changeInLength: (str as NSString).length - range.length)
        endEditing()
    }
    
    override func setAttributes(_ attrs: [NSAttributedString.Key: Any]?, range: NSRange) {
        printValues(String(describing: attrs), range, endSymbol: "\n🌟🌟🌟\n") // <img> -> NSAttachment, NSTextAttachment
        
        if let attrs = attrs,
            let attachement = attrs.first(where: { $0.key == NSAttributedString.Key.attachment })?.value as? NSTextAttachment {
            if let image = attachement.image {
                print(image.size)
            }
            if let fileContents = attachement.fileWrapper?.regularFileContents {
                print(fileContents.count)
            }
            print("⚠️attachment attrs: ", attrs)
            
        }
        beginEditing()
        backingStore.setAttributes(attrs, range: range)
        edited(.editedAttributes, range: range, changeInLength: 0)
        endEditing()
    }
}
