//
//  JobDetailsViewController.swift
//  GitHubJobs
//
//  Created by Tyler Darby on 11/21/15.
//  Copyright © 2015 Darbytron. All rights reserved.
//

import UIKit

class JobDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var job: JobListing?
    @IBOutlet var tableView: UITableView!
    
    @IBAction func applyTapped(sender: AnyObject) {
    }

    @IBAction func viewListingTapped(sender: AnyObject) {
    }
    
    let logoCellIdentifier = "LogoCellIdentifier"
    let jobTitleCellIdentifier = "JobTitleCellIdentifier"
    let descriptionCellIdentifier = "DescriptionCellIdentifier"


    let numberOfRows = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - TableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch(indexPath.row) {
        case 0:
            return createLogoCellForIndexPath(indexPath)
        case 1:
            return createTitleCellForIndexPath(indexPath)
        case 2:
            return createDescriptionCellForIndexPath(indexPath)
        default:
            print("Didn't find the right cell")
            return UITableViewCell()
        }
    }
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch(indexPath.row) {
        case 0:
            return 160
        case 1:
            return 100
        case 2:
            return 83
        default:
            return 44
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch(indexPath.row) {
        case 0:
            return 160
        case 1:
            return 100
        case 2:
            return UITableViewAutomaticDimension
        default:
            return 44
        }
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func createLogoCellForIndexPath(indexPath: NSIndexPath) -> LogoTableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(logoCellIdentifier, forIndexPath: indexPath) as! LogoTableViewCell
        if let cachedImage = job?.cachedImage {
            cell.logoImageView.image = cachedImage
            
        } else {
            if let urlString = job!.companyLogoUrl {
                if let url = NSURL(string: urlString) {
                    JobListingsManager.sharedInstance.downloadImage(url, onComplete: { (logo) -> Void in
                        self.job?.cachedImage = logo
                        cell.logoImageView.image = logo
                        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    })
                }
            }
        }
        
        return cell
    }
    
    func createTitleCellForIndexPath(indexPath: NSIndexPath) -> JobTitleTableViewCell{
        let cell = self.tableView.dequeueReusableCellWithIdentifier(jobTitleCellIdentifier, forIndexPath: indexPath) as! JobTitleTableViewCell
        cell.jobTitle.text = job?.title
        cell.company.text = job?.company;
        cell.jobTypeLocation.text = (job?.type)! + " / " + (job?.location)!
        return cell
    }
    
    func createDescriptionCellForIndexPath(indexPath: NSIndexPath) -> DescriptionTableViewCell{
        let cell = self.tableView.dequeueReusableCellWithIdentifier(descriptionCellIdentifier, forIndexPath: indexPath) as! DescriptionTableViewCell
        do {
            let str = try NSAttributedString(data: (job?.jobDescription!.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            
            cell.jobDescriptionLabel.attributedText = str
            cell.jobDescriptionLabel.font = UIFont.systemFontOfSize(15.0)
            
        } catch {
            print(error)
        }
        return cell
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}


