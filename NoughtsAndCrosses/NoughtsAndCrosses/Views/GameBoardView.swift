//
//  GameBoardView.swift
//  NoughtsAndCrosses
//
//  Created by Russell Gordon on 2022-05-03.
//

import SwiftUI

/// - Tag: game_board
struct GameBoardView: View {
    
    // MARK: Stored properties
    
    // Game board state (all nine positions)
    // Top row
    @State var upperLeft = empty
    @State var upperMiddle = empty
    @State var upperRight = empty
    // Middle row
    @State var middleLeft = empty
    @State var middleMiddle = empty
    @State var middleRight = empty
    // Bottom row
    @State var bottomLeft = empty
    @State var bottomMiddle = empty
    @State var bottomRight = empty
    
    // Tracks whose turn it is
    @State var currentPlayer = nought
    
    // Tracks what turn it is (nine total are possible)
    @State var currentTurn = 1
    
    // Tracks whether game is won or not
    @State var gameWon = false
    
    // Tracks the history of prior games played
    @State var history: [GameResult] = []
    
    // MARK: Computed properties
    var body: some View {
        
        VStack {
            
            Spacer()

            // Current player or who won
            ZStack {
                
                Text("Current player is: \(currentPlayer)")
                // Only show when game is not over
                    .opacity(gameWon == false ? 1.0 : 0.0)
                
                Text("\(currentPlayer) wins!")
                // Only show when game IS over
                    .opacity(gameWon == true ? 1.0 : 0.0)
            }
            .padding(.vertical)

            Spacer()

            // The game board
            Group {
                // Top row
                HStack {
                    // Send connection to properties on this view
                    // to the helper view using a binding
                    TileView(state: $upperLeft,
                             player: currentPlayer,
                             turn: $currentTurn)
                    TileView(state: $upperMiddle,
                             player: currentPlayer,
                             turn: $currentTurn)
                    TileView(state: $upperRight,
                             player: currentPlayer,
                             turn: $currentTurn)
                }
                
                // Middle row
                HStack {
                    TileView(state: $middleLeft,
                             player: currentPlayer,
                             turn: $currentTurn)
                    TileView(state: $middleMiddle,
                             player: currentPlayer,
                             turn: $currentTurn)
                    TileView(state: $middleRight,
                             player: currentPlayer,
                             turn: $currentTurn)
                }
                
                // Bottom row
                HStack {
                    TileView(state: $bottomLeft,
                             player: currentPlayer,
                             turn: $currentTurn)
                    TileView(state: $bottomMiddle,
                             player: currentPlayer,
                             turn: $currentTurn)
                    TileView(state: $bottomRight,
                             player: currentPlayer,
                             turn: $currentTurn)
                }
            }
            
            Spacer()

            // Current turn or new game
            ZStack {
                
                Text("Current turn is: \(currentTurn)")
                    // Only show when game is not over
                    .opacity(gameWon == false ? 1.0 : 0.0)
                
                Button(action: {
                    resetGame()
                }, label: {
                    Text("New Game")
                })
                // Only show when game IS over
                .opacity(gameWon == true ? 1.0 : 0.0)
                
            }
            .padding(.vertical)
            
            Spacer()
            
            HStack {
                Text("History")
                    .font(.title3)
                    .bold()
                Spacer()
            }
            .padding(.horizontal)
            
            // History of prior games played
            List(history) { currentResult in
                GameResultView(result: currentResult)
            }
            
        }
        .onChange(of: currentTurn) { newValue in
            
            print("It's now turn \(newValue), current player is \(currentPlayer)...")

            // Did somebody win?
            checkForWin()
            
        }
        
    }
    
    // MARK: Functions
    
    /// checkForWin
    ///
    /// Looks for all nine win conditions, so long as four turns have occured.
    /// Changes the current player.
    ///
    /// - Tag: winning_condition
    func checkForWin() {
        
        // Only check for win if more than four turns have occured
        if currentTurn > 4 {
            
            // Now check each location
            if
                upperLeft == currentPlayer &&           // Upper row
                upperMiddle == currentPlayer &&
                upperRight == currentPlayer ||
                    
                middleLeft == currentPlayer &&          // Middle row
                middleMiddle == currentPlayer &&
                middleRight == currentPlayer ||
                
                bottomLeft == currentPlayer &&          // Bottom row
                bottomMiddle == currentPlayer &&
                bottomRight == currentPlayer ||
                
                upperLeft == currentPlayer &&           // Left column
                middleLeft == currentPlayer &&
                bottomLeft == currentPlayer ||
                
                upperMiddle == currentPlayer &&         // Middle column
                middleMiddle == currentPlayer &&
                bottomMiddle == currentPlayer ||
                
                upperRight == currentPlayer &&          // Right column
                middleRight == currentPlayer &&
                bottomRight == currentPlayer ||
                
                upperLeft == currentPlayer &&           // Diagonal, left to right
                middleMiddle == currentPlayer &&
                bottomRight == currentPlayer ||
                
                upperRight == currentPlayer &&          // Diagonal, right to left
                middleMiddle == currentPlayer &&
                bottomLeft == currentPlayer
            {
                
                // Game has been won
                gameWon = true
                print("Game won by \(currentPlayer)...")
                
                // Save the result
                saveResult()
                
                // End function now
                return
                
            }
            
        }
        
        // No player won, so change to other player
        if currentPlayer == nought {
            currentPlayer = cross
        } else {
            currentPlayer = nought
        }

    }

    /// Adds the result of a game to a list that tracks the history of prior games played.
    /// - Tag: adding_to_list
    func saveResult() {
        
        // Create an instance of the GameResult structure
        let newResult = GameResult(outcome: gameWon == false ? draw : currentPlayer,    // "Draw" when game
                                                                                        // over but not won...
                                                                                        //
                                                                                        // "⭘" or "✕" otherwise
                                   
                                   turnsTotal: currentTurn - 1,     // If game was won on turn 5,
                                                                    // currentTurn would be 6 when
                                                                    // win is detected

                                   upperLeft: upperLeft,            // Rest of arguments are the state
                                   upperMiddle: upperMiddle,        // of the game board...
                                   upperRight: upperRight,
                                   middleLeft: middleLeft,
                                   middleMiddle: middleMiddle,
                                   middleRight: middleRight,
                                   bottomLeft: bottomLeft,
                                   bottomMiddle: bottomMiddle,
                                   bottomRight: bottomRight)
        
        // Actually add the result to the top of list of results
        history.insert(newResult, at: 0)
        
        // DEBUG: Print the contents of the history list to the console
        print(dump(history))
        
    }
    
    func resetGame() {
        // Clear game board
        upperLeft = empty
        upperMiddle = empty
        upperRight = empty
        middleLeft = empty
        middleMiddle = empty
        middleRight = empty
        bottomLeft = empty
        bottomMiddle = empty
        bottomRight = empty
        
        // New game, has not been won
        gameWon = false
        
        // Start at first turn
        currentTurn = 1
        
        // Noughts goes first
        currentPlayer = nought
    }
}

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView()
    }
}
