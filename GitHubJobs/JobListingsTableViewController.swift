//
//  JobListingsTableViewController.swift
//  GitHubJobs
//
//  Created by Tyler Darby on 11/21/15.
//  Copyright © 2015 Darbytron. All rights reserved.
//

import UIKit

class JobListingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        NSDictionary *textTitleOptions =
//            [NSDictionary dictionaryWithObjectsAndKeys:[UIColor darkGrayColor],
//                UITextAttributeTextColor,
//                [UIColor whiteColor],
//                UITextAttributeTextShadowColor, nil];
//        
//        [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
//        textTitleOptions =
//            [NSDictionary dictionaryWithObjectsAndKeys:[UIColor darkGrayColor],
//                UITextAttributeTextColor, nil];
//        [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
//        [[UIToolbar appearance] setTintColor:[UIColor redColor]];
//        [[UIBarButtonItem appearance] setTintColor:[UIColor redColor]];

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        

        self.navigationController?.navigationItem.title = "GitHub Jobs"
        fetchJobs()
    }
    
    func fetchJobs() {
        JobListingsManager.sharedInstance.refreshJobListings { (jobs: NSArray) -> Void in
            self.tableView.reloadData();
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
        return JobListingsManager.sharedInstance.jobListings.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewVellIdentifier")
        let job = JobListingsManager.sharedInstance.jobListings[indexPath.row];
        cell?.textLabel?.text = job.title;
        cell?.detailTextLabel?.text = job.company! + " - " + job.location!

        
        return cell!
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
