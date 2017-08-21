//
//  ViewController.swift
//  TtroExpandableTableViewSample
//
//  Created by Farid on 8/20/17.
//  Copyright © 2017 ParsPay. All rights reserved.
//

import UIKit
import EasyPeasy

class ViewController: UIViewController {

    var tableView : TtroExpandableTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = TtroExpandableTableView()
        tableView.ttroTableDataSource = self
        view.addSubview(tableView)
        tableView <- Edges(20)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : TtroExpandableTableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

}

