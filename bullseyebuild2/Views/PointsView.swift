//
//  PointsView.swift
//  bullseyebuild2
//
//  Created by Bret Allan Lindquist on 2/4/24.
//

import SwiftUI

struct PointsView: View {
  @Binding var game: Game
  @Binding var showAlert: Bool
  @Binding var oldGoal: Int
  @Binding var sliderValue: Double
  @State private var initialSliderValue: Int = 0
  @State private var initialPointsValue: Int = 0

  var resetGame: () -> Void
  var body: some View {
    VStack(spacing: 10) {
      InstructionText(text: "Goal: \(Int(oldGoal))")

      InstructionText(text: "You Hit: \(Int(initialSliderValue))")
      TotalScoreTextViews(text: "You Scored \(String(initialPointsValue)) points")
      BodyText(text: "👏👏👏")
      Button {
        withAnimation {
          resetGame()
          showAlert = false
        }
      } label: {
        ButtonText(text: "Start New Round")
      }
    }
    .onAppear {
      initialSliderValue = Int(sliderValue)
      initialPointsValue = Int(game.points(oldGoal: oldGoal, sliderValue: Int(sliderValue)))
    }
    .padding()
    .frame(width: 300)
    .background(Color("BackgroundColor"))
    .cornerRadius(Constants.General.roundRectCornerRadius)
    .shadow(radius: 10, x: 5, y: 5)
  }
}

struct PointsView_Previews: PreviewProvider {
  static var previews: some View {
    PointsView(
      game: .constant(Game()),
      showAlert: .constant(false),
      oldGoal: .constant(0),
      sliderValue: .constant(0),
      resetGame: {}
    )
    PointsView(
      game: .constant(Game()),
      showAlert: .constant(false),
      oldGoal: .constant(0),
      sliderValue: .constant(0),
      resetGame: {}
    )
    .previewInterfaceOrientation(.landscapeRight)
    .preferredColorScheme(.dark)
  }
}
