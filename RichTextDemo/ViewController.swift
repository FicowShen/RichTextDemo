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

    let models = [HTML.onlyText, HTML.textAndStaticImage, HTML.textAndGif, HTML.formattedText,
                  HTML.onlyText, HTML.textAndStaticImage, HTML.textAndGif, HTML.formattedText,
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

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
    static let formattedText = """
<head>
<style>
body {background-color: #f0f0f0;}
h1   {color: green;}
p    {color: purple;}
div.Quote {
  color: black;
  border-left: 6px solid red;
  background-color: lightgrey;
}
</style>
</head>
<body>
<b>bold</b><b>Text</b><b></b><br><i>italic</i><i>Text</i><i><br></i><strike>strikeText</strike><i><br></i><b><i><strike>boldAndItalicAndStrike<br></strike></i></b><br><ol><li>Ordered Item 1</li><li>Ordered Item&nbsp;2</li></ol><br><ul><li>Unordered Item 1</li><li>Unordered Item 2<br></li></ul><br><span class="post-color-red">RedColorText<br></span><br><h1>Heading 1</h1><h2>Heading 2</h2><br><div class="Quote">QuoteText</div><br><pre class="CodeBlock"><code>CodeText</code></pre><br><div class="Spoiler">SpoilerText</div><br>Emoji&nbsp; :)  :D  :(  ;)  :/  :o  :s  :p  :'(  :|  B)  :#  :*  &lt;3  o:)  &gt;:) <br><br>Link:&nbsp;<a rel="nofollow" href="http://baidu.com">http://baidu.com/</a> <br><br>File&nbsp;<br><br><img alt="" src="https://us.v-cdn.net/5020794/uploads/editor/aj/m1vcwf0wuk62.png"><br><br><div class="post-text-align-left">Left aligned</div><br><div class="post-text-align-center">Center aligned</div><br><div class="post-text-align-right">Right aligned</div><br><br><br><br><br><br><br><br><br>
<a href=\"https://forums.thebump.com/profile/tennesseelove\" rel=\"nofollow\">@tennesseelove</a> please let us know how your next cycle goes. &nbsp;We are thinking of possibly doing IVF but my husband is very hesitant to spend the money and possibly not respond to the meds and basically throw that money out. &nbsp;Do you mind me asking what your AFC (follicle count on day 3 is?)
<div><br /></div>
<div class="Quote">
My appointment today sucked. It was CD 12 and I am not responding at all, no follicles are growing so we are scraping this cycle. &nbsp;The dr gave us 3 options/thoughts as to what to do next. &nbsp;1) is to try clomid (the past 3 months I have used Femara) I was on clomid back in April and I didn\'t ovulate or grow follicles and got a cyst so i am very hesitant to try it again but she thinks it is worth giving another shot. &nbsp;2) She suggesting taking a 2 month break and taking DHEA as a supplement and possibly acupuncture and then seeing if my amh and/or afc go up. &nbsp;3) IVF but she is hesitant to do that if my AFC is low like it was today. &nbsp;So that would be a game time decision I think if my follicle count is fairly good.&nbsp;
</div>
<div class="Quote">Not sure what we are going to do at this point. &nbsp;Sometimes I think all these meds just aren\'t going to work for my body and we would have a better shot and just trying naturally. &nbsp;But then I get impatient and just want a baby now and think meds are the way to go. &nbsp;If only it weren\'t so expensive.
</div>
</body>
"""
}

func printValues(_ values: Any..., separator: String = "\n", endSymbol: String = "\n", function: String = #function) {
    print(function, "\n")
    print(values.map { "\($0)" }.joined(separator: separator))
    print(endSymbol)
}
