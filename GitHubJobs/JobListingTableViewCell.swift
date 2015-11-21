//
//  JobListingTableViewCell.swift
//  GitHubJobs
//
//  Created by Tyler Darby on 11/21/15.
//  Copyright © 2015 Darbytron. All rights reserved.
//

import UIKit


class JobListingTableViewCell: UITableViewCell {
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobSubtitle: UILabel!    //Lists the Company - Location


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(fromJob job: JobListing) {
        
        if let title = job.title{
            self.jobTitle.text = title
        }
        
        if let company = job.company {
            if let location = job.location{
                self.jobSubtitle.text = company + " - " + location
            } else {
                self.jobSubtitle.text = company
            }
        }
        
        
    }
    
}
