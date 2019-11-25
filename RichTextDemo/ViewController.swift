import UIKit

final class Model: RichTextConvertible {
    let rawHTMLString: String
    var attributedString: NSAttributedString?

    init(rawHTMLString: String) {
        self.rawHTMLString = rawHTMLString
    }
}

final class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView! {
        didSet {
            myTableView.register(MyCell.self, forCellReuseIdentifier: MyCell.reuseId)
            myTableView.dataSource = self
            myTableView.delegate = self
            myTableView.rowHeight = UITableView.automaticDimension
            myTableView.estimatedRowHeight = 88
            myTableView.tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
            myTableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        }
    }

    let models = [HTML.onlyText, HTML.textAndStaticImage, HTML.textAndGif,
                  HTML.onlyText, HTML.textAndStaticImage, HTML.textAndGif,
                  HTML.onlyText, HTML.textAndStaticImage, HTML.textAndGif].map { Model(rawHTMLString: $0) }

//    let textStorage = TextStorage()
//
//    lazy var textView: UITextView = {
//
//        let layoutManager = LayoutManager()
//        textStorage.addLayoutManager(layoutManager)
//
//        let containerSize = CGSize(width: view.bounds.width, height: .greatestFiniteMagnitude)
//        let textContainer = TextContainer(size: containerSize)
//        textContainer.widthTracksTextView = true
//        layoutManager.addTextContainer(textContainer)
//
//        let textView = UITextView(frame: .zero, textContainer: textContainer)
//        return textView
//    }()

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCell.reuseId, for: indexPath) as? MyCell else {
            fatalError()
        }
        cell.indexPath = indexPath
        cell.model = models[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {

}

private enum HTML {
    static let onlyText = """
        Original post:
        <br />
        The current poll system doesn't look like it's going to work. We look like we'll have a bunch of ties and it also doesn't let us vote for more than one person. Scroll to the middle of page one and vote for your top 3 admins by love-titting the names.
        <i>*Please only vote for 3.*</i>
        If you get errors for love-titting, try the web browser on your phone or go on the computer.
        <br />
        ***UPDATE***
        """
    static let textAndStaticImage = """
        ***UPDATE***
        <br />
        The current poll system doesn't look like it's going to work. We look like we'll have a bunch of ties and it also doesn't let us vote for more than one person. Scroll to the middle of page one and vote for your top 3 admins by love-titting the names.
        <i>*Please only vote for 3.*</i>
        If you get errors for love-titting, try the web browser on your phone or go on the computer.
        <br />
        <br />
        <img alt="" src="https://us.v-cdn.net/5020794/uploads/editor/5w/rtd8vfd468sy.png" title="Image: https://us.v-cdn.net/5020794/uploads/editor/5w/rtd8vfd468sy.png" />
        <br />
        <br />
        Original post:
        <br />
        It's time to vote for our private group admins. These will be the ones responsible for adding and screening members into the group, and making sure the group runs smoothly. We'll choose the top 3 at the end of the week. Voting is anonymous, and you can only vote once.
        <br />
        """

    static let textAndGif = """
        ***UPDATE***
        <br />
        The current poll system doesn't look like it's going to work. We look like we'll have a bunch of ties and it also doesn't let us vote for more than one person. Scroll to the middle of page one and vote for your top 3 admins by love-titting the names.
        <i>*Please only vote for 3.*</i>
        If you get errors for love-titting, try the web browser on your phone or go on the computer.
        <br />
        <br />
        Original post:
        <br />
        It's time to vote for our private group admins. These will be the ones responsible for adding and screening members into the group, and making sure the group runs smoothly. We'll choose the top 3 at the end of the week. Voting is anonymous, and you can only vote once.
        <br />
        <br />
        Post a favorite voting meme or gif to keep this bumped up throughout the week.
        <br />
        <img alt="" src="https://b-ssl.duitang.com/uploads/item/201410/25/20141025145601_QkdiW.gif" title="Image: https://b-ssl.duitang.com/uploads/item/201410/25/20141025145601_QkdiW.gif" />
        <br />
        It's time to vote for our private group admins. These will be the ones responsible for adding and screening members into the group, and making sure the group runs smoothly. We'll choose the top 3 at the end of the week. Voting is anonymous, and you can only vote once.
        <br />
        """
}

func printValues(_ values: Any..., separator: String = "\n", endSymbol: String = "\n", function: String = #function) {
    print(function, "\n")
    print(values.map { "\($0)" }.joined(separator: separator))
    print(endSymbol)
}
