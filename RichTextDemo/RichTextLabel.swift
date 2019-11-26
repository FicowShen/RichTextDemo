import UIKit

protocol RichTextLabelLayoutDelegate: class {
    func richTextLabel(_ label: RichTextLabel, needsUpdateHeight height: CGFloat)
}

final class RichTextLabel: UITextView {

    private weak var layoutDelegate: RichTextLabelLayoutDelegate?

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.isEditable = false
        self.isScrollEnabled = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(richText: RichTextConvertible, layoutDelegate: RichTextLabelLayoutDelegate) {
        self.layoutDelegate = layoutDelegate
        updateText(richText: richText)
    }

    private func updateText(richText: RichTextConvertible) {
        attributedText = richText.attributedString
        layoutIfNeeded()
        let size = CGSize(width: bounds.width, height: .greatestFiniteMagnitude)
        let fittedSize = sizeThatFits(size)
        layoutDelegate?.richTextLabel(self, needsUpdateHeight: fittedSize.height)
    }
}

