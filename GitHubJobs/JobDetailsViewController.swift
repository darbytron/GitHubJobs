//
//  JobDetailsViewController.swift
//  GitHubJobs
//
//  Created by Tyler Darby on 11/21/15.
//  Copyright © 2015 Darbytron. All rights reserved.
//

import UIKit
import SafariServices

class JobDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var job: JobListing?
    var hasLogo: Bool!
    var numberOfRows : Int?
    @IBOutlet var tableView: UITableView!
    
    let logoCellIdentifier = "LogoCellIdentifier"
    let jobTitleCellIdentifier = "JobTitleCellIdentifier"
    let descriptionCellIdentifier = "DescriptionCellIdentifier"
    let logoHeight = CGFloat(160)
    let titleHeight = CGFloat(100)
    let descriptionHeight = CGFloat(83)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if let _ = job!.companyLogoUrl {
            hasLogo = true
        } else {
            hasLogo = false
        }
        if hasLogo as Bool {
            numberOfRows = 3
        } else {
            numberOfRows = 2
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "viewCompanyTapped", name: "ViewCompanyTapped", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "viewJobListing", name: "ViewJobListing", object: nil)

    }
    
    func viewCompanyTapped() {
        if let url = job?.companyUrl {
            let safariVC = SFSafariViewController(URL: NSURL(string: url)!)
            self.presentViewController(safariVC, animated: true, completion: nil)
        }
        
    }
    func viewJobListing() {
        if let url = job?.jobListingUrl {
            let safariVC = SFSafariViewController(URL: NSURL(string: url)!)
            self.presentViewController(safariVC, animated: true, completion: nil)
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - TableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var newIndex = indexPath
        
        if !(hasLogo as Bool) {
            newIndex = NSIndexPath(forRow: indexPath.row + 1, inSection: 0)
        }
        
        switch newIndex.row {
        case 0:
            return createLogoCellForIndexPath()
        case 1:
            return createTitleCellForIndexPath()
        case 2:
            return createDescriptionCellForIndexPath()
        default:            
            return UITableViewCell()
        }
        
    }
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var newIndex = indexPath
        
        if !(hasLogo as Bool) {
            newIndex = NSIndexPath(forRow: indexPath.row + 1, inSection: 0)
        }
        
        
        switch newIndex.row {
        case 0:
            return logoHeight
        case 1:
            return titleHeight
        case 2:
            return descriptionHeight
        default:
            return 44
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var newIndex = indexPath
        
        if !(hasLogo as Bool) {
            newIndex = NSIndexPath(forRow: indexPath.row + 1, inSection: 0)
        }
        
        switch newIndex.row {
        case 0:
            return logoHeight
        case 1:
            return titleHeight
        case 2:
            return UITableViewAutomaticDimension
        default:
            return 44
        }
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 64
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return JobDetailsFooterView()
    }
    
    
    
    
    // MARK: TableViewCell Customization
    
    func createLogoCellForIndexPath() -> LogoTableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(logoCellIdentifier) as! LogoTableViewCell
        if let cachedImage = job?.cachedImage {
            cell.logoImageView.image = cachedImage
            
        } else {
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
            activityIndicator.center = cell.center
            cell.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            if let urlString = job!.companyLogoUrl {
                if let url = NSURL(string: urlString) {
                    JobListingsManager.sharedInstance.downloadImage(url, onComplete: { (logo) -> Void in
                        activityIndicator.removeFromSuperview()
                        self.job?.cachedImage = logo
                        cell.logoImageView.image = logo
                        self.tableView.reloadData()
                    })
                }
            } else {
                activityIndicator.removeFromSuperview();
            }
        }
        
        return cell
    }
    
    func createTitleCellForIndexPath() -> JobTitleTableViewCell{
        let cell = self.tableView.dequeueReusableCellWithIdentifier(jobTitleCellIdentifier) as! JobTitleTableViewCell
        cell.jobTitle.text = job?.title
        cell.company.text = job?.company;
        cell.jobTypeLocation.text = (job?.type)! + " / " + (job?.location)!
        return cell
    }
    
    func createDescriptionCellForIndexPath() -> DescriptionTableViewCell{
        let cell = self.tableView.dequeueReusableCellWithIdentifier(descriptionCellIdentifier) as! DescriptionTableViewCell
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


