//
//  AnnouncementsApp.swift
//  Announcements
//
//  Created by Russell Gordon on 2022-04-27.
//

import SwiftUI

@main
struct AnnouncementsApp: App {
    
    // Source of truth for the list of saved announcements
    /// - Tag: a_saved_announcements
    @State var savedAnnouncements: [Announcement] = []

    var body: some Scene {
        WindowGroup {
            
            TabView {

                AnnouncementsListView(savedAnnouncements: $savedAnnouncements)
                    .tabItem {
                        Image(systemName: "person.wave.2")
                        Text("Announcements")
                    }
                
                SavedAnnouncementsListView(savedAnnouncements: $savedAnnouncements)
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Saved")
                    }
            }

        }
    }
}
