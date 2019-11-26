import UIKit

protocol RichTextConvertible: class {
    var attributedString: NSAttributedString? { get set }
    var rawHTMLString: String { get }
}

extension RichTextConvertible {
    func generateRichTextFromHTML(onQueue queue: DispatchQueue = .global(qos: .background),
                                  callbackQueue: DispatchQueue = .main ,
                                  completion: ((NSAttributedString) -> ())?) {
        if let attributedString = attributedString {
            if OperationQueue.current?.underlyingQueue == callbackQueue {
                completion?(attributedString)
            } else {
                callbackQueue.async {
                    completion?(attributedString)
                }
            }
            return
        }
        queue.async {
            let attributedHTMLString = self.rawHTMLString.attributedHTMLString
            callbackQueue.async {
                self.attributedString = attributedHTMLString
                completion?(attributedHTMLString)
            }
        }
    }
}

extension String {
    var attributedHTMLString: NSMutableAttributedString {
        guard let data = self.data(using: .utf8)
            else { return NSMutableAttributedString() }
        do {
            let attributedString = try NSMutableAttributedString(data: data,
                                                                 options: [.documentType : NSAttributedString.DocumentType.html],
                                                                 documentAttributes: nil)
            return attributedString
        } catch {
            print(error.localizedDescription)
            return NSMutableAttributedString()
        }
    }
}

extension NSMutableAttributedString {
    func enumerateTextAttachments(using block: (NSTextAttachment, NSRange, UnsafeMutablePointer<ObjCBool>) -> Void) {
        enumerateAttribute(.attachment, in: NSRange(location: 0, length: string.count), options: .init()) { (attribute, range, stop) in
            guard let attachment = attribute as? NSTextAttachment else { return }
            block(attachment, range, stop)
            print(attachment.contents?.count)
            print(attachment.fileType)
            print(attachment.bounds)
            print(attachment.image)
            //            attributes.removeAttribute(.attachment, range: range)
        }
    }
}
