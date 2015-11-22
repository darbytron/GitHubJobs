//
//  JobTitleTableViewCell.swift
//  GitHubJobs
//
//  Created by Tyler Darby on 11/22/15.
//  Copyright © 2015 Darbytron. All rights reserved.
//

import UIKit

class JobTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var jobTypeLocation: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
