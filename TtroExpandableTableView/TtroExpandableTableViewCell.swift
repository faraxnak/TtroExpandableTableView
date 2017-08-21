//
//  TtroExpandableTableViewCell.swift
//  TtroExpandableTableView
//
//  Created by Farid on 8/20/17.
//  Copyright © 2017 ParsPay. All rights reserved.
//

import UIKit
import DynamicButton
import EasyPeasy

protocol TtroExpandableTableViewCellDelegate : class {
    func expandableCell(onExpand expandableCell: TtroExpandableTableViewCell)
}

class TtroExpandableTableViewCell: UITableViewCell {

    var delegate: TtroExpandableTableViewCellDelegate!
    fileprivate var expandButton : DynamicButton!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        selectionStyle = .none
        expandButton = DynamicButton(style: .plus)
        contentView.addSubview(expandButton)
        
        expandButton <- [
            Right(10),
            Width(25),
            Height().like(expandButton, .width),
            CenterY()
        ]
        expandButton.bounceButtonOnTouch = false
        expandButton.lineWidth = 1
        expandButton.addTarget(self, action: #selector(self.onExpand), for: .touchUpInside)
        
        let label = UILabel()
        label.text = "Touch to expand"
        contentView.addSubview(label)
        label <- [
            Left(20),
            CenterY()
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMode(isExpanded : Bool, animated : Bool){
        if isExpanded {
            expandButton.setStyle(.close, animated: animated)
        } else {
            expandButton.setStyle(.plus, animated: animated)
        }
    }
    
    func onExpand(){
        delegate.expandableCell(onExpand: self)
    }

}
