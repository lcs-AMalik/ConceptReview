//
//  NewSavedAnnouncement.swift
//  Announcements
//
//  Created by Russell Gordon on 2022-05-06.
//

import Foundation

/*
 This structure is used to write a single row to this spreadsheet:
 
 https://docs.google.com/spreadsheets/d/1yy7ZEUfnW5L2jr_IFKh0Nj1NUrTU7PlsCeFU3z-2_Hc/edit#gid=559994916
 
 ... accessed via this endpoint:
 
 https://api.sheety.co/92d7eb80d996eaeb34616393ebc6ddcf/announcements/saved
 
 */
struct NewSavedAnnouncement: Codable {
    
    // NOTE: Sheety requires that this property name be the same as the "sheet" or "tab" name of the spreadsheet
    let saved: SavedAnnouncement
    
    // Defines the endpoint for reading/writing spreadsheet data
    static let endpoint = "https://api.sheety.co/92d7eb80d996eaeb34616393ebc6ddcf/announcements/saved"
    
}
