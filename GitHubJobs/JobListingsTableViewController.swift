//
//  JobListingsTableViewController.swift
//  GitHubJobs
//
//  Created by Tyler Darby on 11/21/15.
//  Copyright © 2015 Darbytron. All rights reserved.
//

import UIKit

class JobListingsTableViewController: UITableViewController {
    var shouldFetch = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationItem.title = "GitHub Jobs"
    }
    
    func fetchJobs() {
        if shouldFetch as Bool {
            let currentCount = JobListingsManager.sharedInstance.jobListings.count
            JobListingsManager.sharedInstance.refreshJobListings ({ () -> Void in
                if currentCount < JobListingsManager.sharedInstance.jobListings.count  {
                    self.tableView.reloadData();
                    self.shouldFetch = true
                } else {
                    self.shouldFetch = false
                    let removeIndex = NSIndexPath(forRow: self.tableView.numberOfRowsInSection(0) - 1, inSection: 0);
                    self.tableView.deleteRowsAtIndexPaths([removeIndex], withRowAnimation: UITableViewRowAnimation.Automatic)
                }
                
            })
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let numListings = JobListingsManager.sharedInstance.jobListings.count
        if shouldFetch as Bool {
            return numListings + 1//Add one for the loading cell
        }
        return numListings
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewVellIdentifier")
        if indexPath.row < JobListingsManager.sharedInstance.jobListings.count {
            let job = JobListingsManager.sharedInstance.jobListings[indexPath.row];
            cell?.textLabel?.text = job.title!;
            cell?.detailTextLabel?.text = job.company! + " - " + job.location!
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        } else {
            //Configure loading view
            cell?.textLabel!.text = "Fetching jobs..."
            cell?.detailTextLabel!.text = ""
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
            activityIndicator.center = (cell?.center)!
            
            cell?.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            cell?.accessoryType = UITableViewCellAccessoryType.None
            
        }
        return cell!
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == tableView.numberOfRowsInSection(0) - 1 {
            fetchJobs()
        }
    }
    
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 54
    }
    
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "JobDetailsIdentifier", let destination = segue.destinationViewController as? JobDetailsViewController {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPathForCell(cell) {
                let job = JobListingsManager.sharedInstance.jobListings[indexPath.row];
                destination.job = job
            }
        }
    }
    

}
