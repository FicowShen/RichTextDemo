import UIKit
import WebKit

final class MyCell: UITableViewCell {

    static let reuseId = String(describing: self)

    var indexPath: IndexPath?
    var loadedHTMLString: String?
    var model: Model? {
        didSet {
            guard let model = self.model,
                model !== oldValue
                else { return }
            loadedHTMLString = model.rawHTMLString
            webview.loadHTMLString(model.rawHTMLString, baseURL: nil)
//            guard let _ = model.attributedString else {
//                model.generateRichTextFromHTML { [weak self] _ in
//                    guard let self = self else { return }
//                    self.richTextLabel.setup(richText: model, layoutDelegate: self)
//                }
//                return
//            }
//            richTextLabel.setup(richText: model, layoutDelegate: self)
        }
    }

    private lazy var webview = WKWebView()
//    private lazy var richTextLabel = RichTextLabel()
    private var heightConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 2000)
        contentViewHeightConstraint.priority = .defaultHigh
        contentViewHeightConstraint.isActive = true

        webview.navigationDelegate = self
        contentView.addSubview(webview)
        webview.frame = contentView.bounds
//        heightConstraint = webview.heightAnchor.constraint(equalToConstant: 500)
//        heightConstraint?.isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        webview.frame = contentView.bounds
    }
}

extension MyCell: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.sizeToFit()
//        print(webView.intrinsicContentSize)
//        print(webView.scrollView.contentSize.height)

        webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
            guard let height = height as? CGFloat else { return }
            print(height)
            webView.frame.size.height = height
        })
//        webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
//            guard complete != nil else {
//                return
//            }
//            webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { [weak self] (height, error) in
//                guard let self = self,
//                    let height = height as? CGFloat
//                    else { return }
//                self.heightConstraint?.constant = height
//                guard let indexPath = self.indexPath,
//                    let tableView = self.superview as? UITableView
//                    else { return }
//
//                tableView.performBatchUpdates({
//                    tableView.reloadRows(at: [indexPath], with: .none)
//                }, completion: nil)
//            })
//        })


//        let fittedSize = webView.scrollView.contentSize
//        heightConstraint?.constant = fittedSize.height
//        guard let indexPath = indexPath else { return }
//        (superview as? UITableView)?.reloadRows(at: [indexPath], with: .none)
    }
}

extension MyCell: RichTextLabelLayoutDelegate {
    func richTextLabel(_ label: RichTextLabel, needsUpdateHeight height: CGFloat) {
        heightConstraint?.constant = height
        guard let indexPath = indexPath else { return }
        (superview as? UITableView)?.reloadRows(at: [indexPath], with: .none)
    }
}
