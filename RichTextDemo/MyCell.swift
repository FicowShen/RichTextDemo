import UIKit

final class MyCell: UITableViewCell {

    static let reuseId = String(describing: self)

    var indexPath: IndexPath?
    var model: Model? {
        didSet {
            guard let model = self.model else { return }
            guard let _ = model.attributedString else {
                model.generateRichTextFromHTML { [weak self] _ in
                    guard let self = self else { return }
                    self.richTextLabel.setup(richText: model, layoutDelegate: self)
                }
                return
            }
            richTextLabel.setup(richText: model, layoutDelegate: self)
        }
    }

    private lazy var richTextLabel = RichTextLabel()
    private var heightConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(richTextLabel)
        richTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([richTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     richTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     richTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                     richTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
        heightConstraint = richTextLabel.heightAnchor.constraint(equalToConstant: 32)
        heightConstraint?.priority = .defaultHigh
        heightConstraint?.isActive = true
    }
}

extension MyCell: RichTextLabelLayoutDelegate {
    func richTextLabel(_ label: RichTextLabel, needsUpdateHeight height: CGFloat) {
        heightConstraint?.constant = height
        guard let indexPath = indexPath else { return }
        (superview as? UITableView)?.reloadRows(at: [indexPath], with: .none)
    }
}
