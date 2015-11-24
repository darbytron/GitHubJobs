//
//  JobDetailsFooterView.swift
//  GitHubJobs
//
//  Created by Tyler Darby on 11/23/15.
//  Copyright © 2015 Darbytron. All rights reserved.
//

import UIKit


class JobDetailsFooterView: UIView {
    @IBOutlet var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        view = NSBundle.mainBundle().loadNibNamed("JobDetailsFooter", owner: self, options: nil)[0] as! UIView
        view.bounds = self.bounds
        view.frame = self.frame
        self.addSubview(self.view)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    @IBAction func viewCompanyTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("ViewCompanyTapped", object: self)
    }

    @IBAction func viewJobListing(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("ViewJobListing", object: self)
        
    }

}
