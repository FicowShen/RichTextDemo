//
//  ViewController.swift
//  RichTextDemo
//
//  Created by Ficow on 2019/11/24.
//  Copyright © 2019 ficow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let textStorage = TextStorage()
    
    lazy var textView: UITextView = {
        
        let layoutManager = LayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let containerSize = CGSize(width: view.bounds.width, height: .greatestFiniteMagnitude)
        let textContainer = TextContainer(size: containerSize)
        textContainer.widthTracksTextView = true
        layoutManager.addTextContainer(textContainer)
        
        let textView = UITextView(frame: .zero, textContainer: textContainer)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        
        let attr = try! NSMutableAttributedString(data: text.data(using: .utf8)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
        print(attr)
        
        textStorage.append(attr)
    }

    let text = """
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
<img alt="" src="https://media.giphy.com/media/3DsNP07nApt1eEyjvM/giphy.gif" title="Image: https://us.v-cdn.net/5020794/uploads/editor/5w/rtd8vfd468sy.png" />
<br />
"""

    // https://us.v-cdn.net/5020794/uploads/editor/5w/rtd8vfd468sy.png
    // https://media.giphy.com/media/3DsNP07nApt1eEyjvM/giphy.gif
}

func printValues(_ values: Any..., separator: String = "\n", endSymbol: String = "\n", function: String = #function) {
    print(function, "\n")
    print(values.map { "\($0)" }.joined(separator: separator))
    print(endSymbol)
}
