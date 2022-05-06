//
//  SpinningStarView.swift
//  Announcements
//
//  Created by Russell Gordon on 2022-05-06.
//

import SwiftUI

struct SpinningStarView: View {
    
    // MARK: Stored properties
    @State var emptyStarOpacity = 1.0
    @State var filledStarOpacity = 0.0
    @State var starRotation = 0.0
    
    // Whether the star is "active" or not
    @Binding var active: Bool
    
    // MARK: Computed properties
    var body: some View {
        
        ZStack {

            // Filled star
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.yellow)
                // Visible when star is NOT active (so we can "turn off" the star)
                .opacity(active == false ? filledStarOpacity : emptyStarOpacity)
                .rotation3DEffect(.degrees(active == true ? 720.0 : 0.0),
                                  axis: (x: 0, y: 1, z: 0))
            
            // Empty star
            Image(systemName: "star")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.yellow)
                // Visible when star IS active (so we can "turn on" the star)
                .opacity(active == true ? filledStarOpacity : emptyStarOpacity)
                .rotation3DEffect(.degrees(active == true ? 720.0 : 0.0),
                                  axis: (x: 0, y: 1, z: 0))

        }
        
    }
}

struct SpinningStarView_Previews: PreviewProvider {
    static var previews: some View {
        SpinningStarView(active: .constant(true))
    }
}
