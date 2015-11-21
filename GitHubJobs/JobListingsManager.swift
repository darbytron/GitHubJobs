//
//  JobListingsManager.swift
//  GitHubJobs
//
//  Created by Tyler Darby on 11/21/15.
//  Copyright © 2015 Darbytron. All rights reserved.
//

import UIKit

class JobListingsManager: NSObject {
    static let sharedInstance = JobListingsManager()
    var jobListings = [JobListing]()
    
    let baseURL = "https://jobs.github.com/positions.json?page=1"
    private override init() {} //This prevents others from using the default '()' initializer for this class.
    
    

    func refreshJobListings(onCompletion: (jobs: NSArray) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: baseURL)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling GET on /posts/1")
                print(error)
                return
            }
            // parse the result as JSON, since that's what the API provides
            
            do {
                let jsonArray = try NSJSONSerialization.JSONObjectWithData(responseData,
                    options: []) as! NSArray
                for dict in jsonArray{
                    let job = JobListing.init(fromDictionary: dict as! NSDictionary);
                    self.jobListings.append(job)
                }
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            onCompletion(jobs: self.jobListings)
        })
        task.resume()
    }
}


