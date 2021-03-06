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
import PayWandBasicElements

protocol TtroExpandableTableViewCellDelegate : class {
    func expandableCell(onExpand expandableCell: TtroExpandableTableViewCell)
}

class TtroExpandableTableViewCell: UITableViewCell {

    var delegate: TtroExpandableTableViewCellDelegate!
    fileprivate var expandButton : DynamicButton!
    
    var label : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        selectionStyle = .none
        expandButton = DynamicButton(style: .plus)
        contentView.addSubview(expandButton)
        
        expandButton.easy.layout([
            Right(20),
            Width(20),
            Height().like(expandButton, .width),
            CenterY()
        ])
        expandButton.bounceButtonOnTouch = false
        expandButton.lineWidth = 1
        expandButton.strokeColor = UIColor.TtroColors.white.color
        expandButton.highlightStokeColor = UIColor.TtroColors.white.color
        expandButton.addTarget(self, action: #selector(self.onExpand), for: .touchUpInside)
        
        label = TtroLabel(font: UIFont.TtroPayWandFonts.regular2.font, color: UIColor.TtroColors.white.color)
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        contentView.addSubview(label)
        label.easy.layout([
            Left(20),
            CenterY(),
            Right(10).to(expandButton, .left),
            Height().like(contentView)
        ])
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
    
    func setFontColor(textColor: UIColor?, font: UIFont?, buttonColor : UIColor?){
        if let color = textColor {
            label.textColor = color
        }
        if let color = buttonColor {
            expandButton.strokeColor = color
        }
        if let font = font {
            label.font = font
        }
    }
    
    @objc func onExpand(){
        delegate.expandableCell(onExpand: self)
    }

}
