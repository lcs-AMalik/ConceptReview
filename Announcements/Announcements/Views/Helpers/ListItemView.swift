//
//  ListItemView.swift
//  Announcements
//
//  Created by Russell Gordon on 2022-04-27.
//

import SwiftUI

struct ListItemView: View {
    
    // MARK: Stored properties
    let currentAnnouncement: Announcement
    
    // MARK: Computed properties
    var body: some View {

        VStack(alignment: .leading) {
            Text(currentAnnouncement.title)
                .font(.headline)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("**Posted by:** \(currentAnnouncement.postedBy)")
                    Spacer()
                }
                .font(.caption)
                
                Text(currentAnnouncement.date)
                    .font(.caption)
            }
        }

    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(currentAnnouncement: testAnnouncement)
    }
}
