//
//  SavedAnnouncement.swift
//  Announcements
//
//  Created by Russell Gordon on 2022-05-06.
//

import Foundation

/*
 Each instance of this structure corresponds to a single row in this spreadsheet:
 
 https://docs.google.com/spreadsheets/d/1yy7ZEUfnW5L2jr_IFKh0Nj1NUrTU7PlsCeFU3z-2_Hc/edit#gid=559994916

 The `id` property is the row number in the spreadsheet.
 
 Other properties match the columns of the spreadsheet, from left to right.

 The spreadsheet is accessed via this endpoint:
 
 https://api.sheety.co/92d7eb80d996eaeb34616393ebc6ddcf/announcements/saved
 
 */
struct SavedAnnouncement: Codable, Identifiable {
    
    let savedAnnouncementId: Int
    var id: Int = 0     // Will be replaced with each row's number...
                        // A default is required to simplify logic to add a new row
                        // when sending data to Sheety

}
