//
//  JobListing.swift
//  GitHubJobs
//
//  Created by Tyler Darby on 11/21/15.
//  Copyright © 2015 Darbytron. All rights reserved.
//

import UIKit

class JobListing: NSObject {
    
    var jobID: String?
    var title: String?
    var location: String?
    var jobDescription: String? //html
    var company: String?
    var type: String?           //make this an enum
    var howToApply: String?     //html link
    var companyUrl: String?
    var companyLogoUrl: String?
    var jobListingUrl: String?
    
    
    init(fromDictionary dict: NSDictionary){
        if  let j = dict["id"] as? String {
            self.jobID = j
        }
        if  let j = dict["title"] as? String{
            self.title = j;
        }
        if  let j = dict["location"] as? String{
            self.location = j;
        }
        if  let j = dict["description"] as? String{
            self.jobDescription = j;
        }
        if  let j = dict["company"] as? String{
            self.company = j;
        }
        if  let j = dict["type"] as? String{
            self.type = j;
        }
        if  let j = dict["how_to_apply"] as? String{
            self.howToApply = j;
        }
        if  let j = dict["company_url"] as? String{
            self.companyUrl = j;
        }
        if  let j = dict["company_logo"] as? String{
            self.companyLogoUrl = j;
        }
        if  let j = dict["url"] as? String{
            self.jobListingUrl = j;
        }
        
        
    }
}



