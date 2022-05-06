//
//  Announcement.swift
//  Announcements
//
//  Created by Russell Gordon on 2022-04-27.
//

import Foundation

/*
 Each instance of this structure corresponds to a single row in this spreadsheet:
 
 https://docs.google.com/spreadsheets/d/1yy7ZEUfnW5L2jr_IFKh0Nj1NUrTU7PlsCeFU3z-2_Hc/edit#gid=0

 The `id` property is the row number in the spreadsheet.
 
 Other properties match the columns of the spreadsheet, from left to right.

 The spreadsheet is accessed via this endpoint:
 
 https://api.sheety.co/92d7eb80d996eaeb34616393ebc6ddcf/announcements/list
 
 */
struct Announcement: Codable, Identifiable {
    let postedBy: String
    let date: String
    let title: String
    let body: String
    let imageUrl: String
    let id: Int
}

let testAnnouncement = Announcement(postedBy: "David Crispo",
                                    date: "4/27/2022",
                                    title: "Airbands update 🎸",
                                    body: "Good morning, all houses should now have a time for an Airbands sound check in the theatre. \n\nSome important reminders:\n\n• The time slots are only 15 minutes, please make sure that you're there on time and you leave your bags/coats in the theatre lobby so we can get everyone through. \n\n• There are pieces of the set still in the theatre, please do not touch any of it.  \n\nIn the words of Martha Graham, \"Dance is the hidden language of the soul\" \n\nThanks everyone!",
                                    imageUrl: "https://www.russellgordon.ca/lcs/2021-22/sheety-demo/airband.jpg",
                                    id: 2)

let testListOfAnnouncements = [
    
    Announcement(postedBy: "David Crispo",
                 date: "4/27/2022",
                 title: "Airbands update 🎸",
                 body: "Good morning, all houses should now have a time for an Airbands sound check in the theatre. \n\nSome important reminders:\n\n• The time slots are only 15 minutes, please make sure that you're there on time and you leave your bags/coats in the theatre lobby so we can get everyone through. \n\n• There are pieces of the set still in the theatre, please do not touch any of it.  \n\nIn the words of Martha Graham, \"Dance is the hidden language of the soul\" \n\nThanks everyone!",
                 imageUrl: "https://www.russellgordon.ca/lcs/2021-22/sheety-demo/airband.jpg",
                 id: 2)
    
    ,
    
    Announcement(postedBy: "Mr. Pete O'Grady",
                 date: "4/26/2022",
                 title: "SIC Voting Extended Again 🗳",
                 body: "Good morning.\n\nDue to the fire alarm, the ballot for this morning's voting will stay open until 1:00 PM for anyone who did not get the chance to vote.\n\nYou can access the ballot through your advising group.\n\nThank you.\n\nOG",
                 imageUrl: "https://www.russellgordon.ca/lcs/2021-22/sheety-demo/voting.jpg",
                 id: 3)
    ,
    
    Announcement(postedBy: "Ms. Tina St. John",
                 date: "4/26/2022",
                 title: "Beach League 🏝",
                 body: "It's ALMOST warm enough to start our BEACH LEAGUE. \n\nIf there are any last minute players/teams that want to join send me a quick note and I'll add you to the schedule. \n\nWe will start the first Saturday in May - BUT if it's nice this weekend you should get practice in with your team ☺️",
                 imageUrl: "https://www.russellgordon.ca/lcs/2021-22/sheety-demo/volleyball.jpg",
                 id: 4)

    
]
