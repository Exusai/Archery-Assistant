//
//  StatsTableViewController.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 08/05/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import UIKit

class StatsTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}
