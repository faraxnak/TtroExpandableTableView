//
//  TtroExpandedTableViewCell.swift
//  TtroExpandableTableView
//
//  Created by Farid on 8/20/17.
//  Copyright © 2017 ParsPay. All rights reserved.
//

import UIKit
import EasyPeasy
import PayWandBasicElements

class TtroExpandedTableViewCell: UITableViewCell {
    
    var textView : UILabel!//UITextView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        selectionStyle = .none
        
        
//        textLabel?.text = " "
//        textLabel?.numberOfLines = 5
//        textLabel?.lineBreakMode = .byWordWrapping
//        textLabel?.textColor = UIColor.white
        
        textView = UILabel()
        contentView.addSubview(textView)
        textView <- [
            Top(10),
            Bottom(10),
            Right(20),
            Left(20)
        ]
        textView.textColor = UIColor.white
        textView.numberOfLines = 0
        textView.lineBreakMode = .byWordWrapping
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.TtroPayWandFonts.light3.font
    }
    
    func setFontColor(textColor: UIColor?, font: UIFont?){
        if let color = textColor {
            textView.textColor = color
        }
        if let font = font {
            textView.font = font
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
