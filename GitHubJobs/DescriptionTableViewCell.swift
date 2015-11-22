//
//  DescriptionTableViewCell.swift
//  GitHubJobs
//
//  Created by Tyler Darby on 11/22/15.
//  Copyright © 2015 Darbytron. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var jobDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
