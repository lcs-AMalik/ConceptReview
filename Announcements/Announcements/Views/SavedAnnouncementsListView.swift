//
//  SavedAnnouncementsListView.swift
//  Announcements
//
//  Created by Russell Gordon on 2021-02-21.
//

import SwiftUI

struct SavedAnnouncementsListView: View {
    
    // MARK: Stored properties
    
    // Derived value; a reference to the list of announcements that have been saved
    @Binding var savedAnnouncements: [Announcement]
    
    // MARK: Computed properties
    var body: some View {
        
        NavigationView {
            
            VStack {
                // Show message if no saved announcements
                if savedAnnouncements.isEmpty {

                    Spacer()
                    
                    Text("No saved announcements yet")
                        .font(.title)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()

                } else {

                    // Show list of saved announcements
                    List(savedAnnouncements) { currentItem in

                        NavigationLink(destination: {
                            AnnouncementDetailView(currentAnnouncement: currentItem,
                                                   isSaved: true,
                                                   savedAnnouncements: $savedAnnouncements)
                        }, label: {
                            ListItemView(currentAnnouncement: currentItem)
                        })
                        
                    }
                    
                }
            }
            .navigationTitle("Saved")
            
        }
        
    }
}

struct SavedAnnouncementsListView_Previews: PreviewProvider {
    static var previews: some View {
        SavedAnnouncementsListView(savedAnnouncements: .constant([testAnnouncement]))
    }
}
