//
//  TtroExpandableTableView.swift
//  TtroExpandableTableView
//
//  Created by Farid on 8/20/17.
//  Copyright © 2017 ParsPay. All rights reserved.
//

import UIKit

protocol TtroExpandableTableViewDelegate : UITableViewDataSource {
    
}

open class TtroExpandableTableView : UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var selectedCellIndexPath : IndexPath?
    
    var ttroTableDataSource : TtroExpandableTableViewDelegate!
    
    var expandStateArray : [Int:Array<Bool>] = [:]
    
    var isAnimating = false
    
    public convenience init() {
        self.init(frame: .zero, style: .plain)
        register(TtroExpandedTableViewCell.self, forCellReuseIdentifier: String(describing: TtroExpandedTableViewCell.self))
        register(TtroExpandableTableViewCell.self, forCellReuseIdentifier: String(describing: TtroExpandableTableViewCell.self))
        delegate = self
        dataSource = self
    }
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    open func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isAnimating { return }
        
        if let cell = tableView.cellForRow(at: indexPath) as? TtroExpandableTableViewCell {
            //CATransaction.begin()
            tableView.beginUpdates()
//            isAnimating = true
//            CATransaction.setCompletionBlock { [weak self] in
//                self?.isAnimating = false
//            }
            var expandableIndexPath = self.expandableIndexPath(newSelectedIndexPath: indexPath)
            if expandStateArray[expandableIndexPath.section]?[expandableIndexPath.row] ?? false {
                selectedCellIndexPath = nil
                if let cell = tableView.cellForRow(at: IndexPath(row: expandableIndexPath.row + 1, section: expandableIndexPath.section)) {
                    UIView.animate(withDuration: 0.2, animations: {
                        cell.contentView.alpha = 0
                    })
                }
                tableView.deleteRows(at: [IndexPath(row: expandableIndexPath.row + 1, section: expandableIndexPath.section)], with: .automatic)
                expandStateArray[expandableIndexPath.section]?[expandableIndexPath.row] = false
                cell.setMode(isExpanded: false, animated: true)
            } else {
                if selectedCellIndexPath != nil {
                    let expandedIndexPath = IndexPath(row: selectedCellIndexPath!.row + 1, section: selectedCellIndexPath!.section)
                    if let cell = tableView.cellForRow(at: expandedIndexPath) {
                        UIView.animate(withDuration: 0.2, animations: { 
                            cell.contentView.alpha = 0
                        })
                    }
                    tableView.deleteRows(at: [expandedIndexPath], with: .automatic)
                    if let cell = tableView.cellForRow(at: selectedCellIndexPath!) as? TtroExpandableTableViewCell {
                        cell.setMode(isExpanded: false, animated: true)
                    }
                    expandStateArray[selectedCellIndexPath!.section]?[selectedCellIndexPath!.row] = false
                }
                selectedCellIndexPath = expandableIndexPath
                tableView.insertRows(at: [IndexPath(row: selectedCellIndexPath!.row + 1, section: selectedCellIndexPath!.section)], with: .automatic)
                expandStateArray[expandableIndexPath.section]?[expandableIndexPath.row] = true
                cell.setMode(isExpanded: true, animated: true)
            }
            tableView.endUpdates()
            //CATransaction.commit()
        }
    }
    
    open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let n = ttroTableDataSource.tableView(self, numberOfRowsInSection: section)
        if (n != 0) {
            if var sectionStates = expandStateArray[section] {
                if n > sectionStates.count {
                    sectionStates.append(contentsOf: [Bool](repeating: false, count: n - sectionStates.count))
                    expandStateArray[section] = sectionStates
                }
            } else {
                expandStateArray[section] = [Bool](repeating: false, count: n)
            }
        }
        
        if selectedCellIndexPath != nil &&
            selectedCellIndexPath?.section == section {
            return ttroTableDataSource.tableView(self, numberOfRowsInSection: section) + 1
        } else {
            return ttroTableDataSource.tableView(self, numberOfRowsInSection: section)
        }
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedCellIndexPath != nil &&
            indexPath.row == selectedCellIndexPath!.row + 1 &&
            indexPath.section == selectedCellIndexPath!.section {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TtroExpandedTableViewCell.self))!
            cell.contentView.alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
                cell.contentView.alpha = 1
            })
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TtroExpandableTableViewCell.self)) as! TtroExpandableTableViewCell
            cell.delegate = self
            if selectedCellIndexPath != nil &&
                indexPath.row == selectedCellIndexPath!.row &&
                indexPath.section == selectedCellIndexPath!.section {
                cell.setMode(isExpanded: true, animated: false)
            } else {
                cell.setMode(isExpanded: false, animated: false)
            }
            return cell
        }
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return ttroTableDataSource.numberOfSections?(in: self) ?? 1
    }
    
    func expandableIndexPath(newSelectedIndexPath indexPath: IndexPath) -> IndexPath {
        if let currentSelectedIndexPath = selectedCellIndexPath {
            if indexPath.section == currentSelectedIndexPath.section &&
                indexPath.row > currentSelectedIndexPath.row  {
                return IndexPath(row: indexPath.row - 1, section: indexPath.section)
            } else {
                return indexPath
            }
        } else {
            return indexPath
        }
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedCellIndexPath != nil &&
            indexPath.section == selectedCellIndexPath!.section &&
            indexPath.row == selectedCellIndexPath!.row + 1 {
            return 100
        } else {
            return 50
        }
    }

}

extension TtroExpandableTableView : TtroExpandableTableViewCellDelegate {
    func expandableCell(onExpand expandableCell: TtroExpandableTableViewCell) {
        if let indexPath = indexPath(for: expandableCell) {
            tableView(self, didSelectRowAt: indexPath)
        }
    }
}
