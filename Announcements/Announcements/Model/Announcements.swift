//
//  Announcements.swift
//  Announcements
//
//  Created by Russell Gordon on 2022-05-06.
//

import Foundation

/*
 This structure will be populated with rows from this spreadsheet:
 
 https://docs.google.com/spreadsheets/d/1yy7ZEUfnW5L2jr_IFKh0Nj1NUrTU7PlsCeFU3z-2_Hc/edit#gid=0
 
 ... accessed via this endpoint:
 
 https://api.sheety.co/92d7eb80d996eaeb34616393ebc6ddcf/announcements/list
 
 */
struct Announcements: Codable {
    
    // Will eventually be populated with data matching all the rows of the spreadsheet
    // Begins as an empty list
    var list: [Announcement] = []
    
    // Defines the endpoint for reading/writing spreadsheet data
    static let endpoint = "https://api.sheety.co/92d7eb80d996eaeb34616393ebc6ddcf/announcements/list"
    
}
