//
//  AnnouncementsListView.swift
//  Announcements
//
//  Created by Russell Gordon on 2022-04-27.
//

import SwiftUI

struct AnnouncementsListView: View {
    
    // MARK: Stored properties
    
    // List of announcements that will be loaded from the Sheety endpoint in JSON format
    /// - Tag: a_announcements_list
    @State var announcementsToShow: [Announcement] = []
    
    // Derived value; a reference to the list of announcements that have been saved
    // The source of truth (original instance) is at the app level
    @Binding var savedAnnouncements: [Announcement]
    
    // MARK: Computed properties
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                // Shows list of announcements, when there are some to show
                List(announcementsToShow) { currentListItem in

                    NavigationLink(destination: {
                        AnnouncementDetailView(currentAnnouncement: currentListItem,
                                               isSaved: false,
                                               savedAnnouncements: $savedAnnouncements)
                    }, label: {
                        ListItemView(currentAnnouncement: currentListItem)
                    })
                    
                }
                
                // Show a message when there are no results yet
                VStack {
                    Spacer()
                    
                    Text("Loading...")
                        .font(.title)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .opacity(announcementsToShow.isEmpty ? 1.0 : 0.0)

            }
            .navigationTitle("Announcements 📢")
            .navigationBarTitleDisplayMode(.large)
            // Runs once when view is loaded
            .task {
                
                await fetchResults()
                
            }

        }
        
    }
    
    // MARK: Functions
    func fetchResults() async {
        
        // Set the address of the JSON endpoint
        let url = URL(string: Announcements.endpoint)!
        
        // Configure a URLRequest instance
        // Defines what type of request will be sent to the address noted above
        var request = URLRequest(url: url)
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"  // Getting data from the web server...
        
        // Start a URL session to interact with the endpoint
        let urlSession = URLSession.shared
        
        // Fetch the results of this search
        do {
            // Get the raw data from the endpoint
            let (data, _) = try await urlSession.data(for: request)
            
            // DEBUG: See what raw JSON data was returned from the server
            print(String(data: data, encoding: .utf8)!)
            
            // Attempt to decode and return the object all the rows of the spreadsheet
            // NOTE: We decode to Announcements.self since the endpoint
            //       returns a single JSON object
            let decodedAnnouncements = try JSONDecoder().decode(Announcements.self, from: data)
            
            // Now, we access the rows of the spreadsheet
            announcementsToShow = decodedAnnouncements.list
            
        } catch {
            
            // Report about what happened
            print("Could not retrieve / decode JSON from endpoint.")
            print(error)
            
        }
        
    }

}

struct AnnouncementsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AnnouncementsListView(announcementsToShow: testListOfAnnouncements,
                                  savedAnnouncements: .constant([testAnnouncement]))
        }
    }
}
