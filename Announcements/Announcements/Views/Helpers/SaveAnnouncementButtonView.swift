//
//  SaveAnnouncementButtonView.swift
//  Announcements
//
//  Created by Russell Gordon on 2022-05-05.
//

import SwiftUI

struct SaveAnnouncementButtonView: View {
    
    // MARK: Stored properties
    
    // The announcement being shown
    let announcement: Announcement
    
    // Has this announcement been saved?
    @Binding var isSaved: Bool
    
    // The list of saved announcements
    @Binding var savedAnnouncements: [Announcement]
    
    // MARK: Computed properties
    var body: some View {
        
        // Button to save this announcement
        HStack {
            SpinningStarView(active: $isSaved)
            
            Text(isSaved ? "Forget this\nannouncement" : "Remember\nthis announcement")
                .foregroundColor(.blue)
                .multilineTextAlignment(.leading)
                // Don't animate the change in text when the announcement is saved
                .animation(.none, value: isSaved)
        }
        .onTapGesture {
            addOrRemoveAnnouncementFromSavedList()
        }
       
    }
    
    // MARK: Functions
    /// - Tag: a_selection_statement
    func addOrRemoveAnnouncementFromSavedList() {
        
        // Is this announcement in the list of saved announcements?
        if isSaved == false {
            
            // OK then, add it to the list
            savedAnnouncements.append(announcement)
            
            // Send the fact that this announcement was saved up to the spreadsheet
            Task {
                await reportSavedAnnouncement()
            }
            
            // This ensures the state changes on SpinningStarView are animated
            withAnimation (
                Animation.easeInOut(duration: 0.5)
            ) {
                isSaved = true
            }
            
            // DEBUG: What's in the list now?
            print(dump(savedAnnouncements))
            
        } else {
            
            // Find where this song is in the list of announcements, then remove it
            // This iterates over the entire "savedAnnouncements" list, looking
            // for a match to the current announcement...
            savedAnnouncements.removeAll(where: { currentAnnouncementInList in
                currentAnnouncementInList.id == announcement.id
            })
            
            // This ensures the state changes on SpinningStarView are animated
            withAnimation (
                Animation.easeInOut(duration: 0.5)
            ) {
                isSaved = false
            }
            
            // DEBUG: What's in the list now?
            print(dump(savedAnnouncements))


        }
        
    }
    
    /// - Tag: a_sequence
    func reportSavedAnnouncement() async {
        
        // Keep track of what announcement was saved
        let thisSavedAnnouncement = SavedAnnouncement(savedAnnouncementId: announcement.id)
        
        // Set up an instance of the structure we need to use to send a new row to the spreadsheet
        let newRowInSpreadsheet = NewSavedAnnouncement(saved: thisSavedAnnouncement)
        
        // Create an encoder object
        let encoder = JSONEncoder()
        
        // Ensure that generated JSON is easy to read, for debugging purposes
        encoder.outputFormatting = .prettyPrinted
        
        // Actually encode and send the user's information
        do {
            // Try to encode the data being sent to the spreadsheet in JSON format
            let encoded = try encoder.encode(newRowInSpreadsheet)
            
            // DEBUG: What has been encoded?
            print("Data that will be sent to Sheety is: ")
            print(String(data: encoded, encoding: .utf8)!)
            
            // Prepare a URLRequest to send our encoded data as JSON
            let url = URL(string: NewSavedAnnouncement.endpoint)!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST" // Sending data to the web server
            request.httpBody = encoded  // Add the data we are sending to the body of the request
            
            // Start a URL session to interact with the endpoint
            let urlSession = URLSession.shared

            // Get the response from Sheety when we send the data up
            let (responseFromSheety, _) = try await urlSession.data(for: request)
            
            // The response from Sheety...
            // NOTE: If successful, we should see a JSON object that has the row number of the new entry in the spreadsheet
            print("Sheety service response is:\n\(String(data: responseFromSheety, encoding: .utf8)!)")
            
        } catch {
            
            // Report about what happened
            print("Could not encode / send JSON to endpoint.")
            print(error)
            
        }
        
    }
    
    
}

struct SaveAnnouncementButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SaveAnnouncementButtonView(announcement: testAnnouncement,
                          isSaved: .constant(true),
                          savedAnnouncements: .constant([]))
    }
}
