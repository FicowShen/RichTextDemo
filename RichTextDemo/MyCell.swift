import UIKit

final class MyCell: UITableViewCell {

    static let reuseId = String(describing: self)

    var indexPath: IndexPath?
    var model: Model? {
        didSet {
            guard let model = self.model else { return }
            guard let attributedString = model.attributedString else {
                model.generateRichTextFromHTML { [weak self] attributedHTMLString in
                    self?.updateText(attributedHTMLString: attributedHTMLString, forModel: model)
                }
                return
            }
            updateText(attributedHTMLString: attributedString, forModel: model)
        }
    }

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    private var heightConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                     textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
        heightConstraint = textView.heightAnchor.constraint(equalToConstant: 8)
        heightConstraint?.priority = .defaultHigh
        heightConstraint?.isActive = true
    }

    private func updateText(attributedHTMLString: NSAttributedString, forModel model: Model) {
        guard model === self.model,
            let indexPath = indexPath else { return }
        textView.attributedText = attributedHTMLString
        textView.layoutIfNeeded()
        let height = textView.sizeThatFits(.init(width: textView.bounds.width, height: .greatestFiniteMagnitude)).height
        heightConstraint?.constant = height
        (superview as? UITableView)?.reloadRows(at: [indexPath], with: .none)
    }
}
