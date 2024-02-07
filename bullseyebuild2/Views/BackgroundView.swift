//
//  BackgroundView.swift
//  bullseyebuild2
//
//  Created by Bret Allan Lindquist on 2/2/24.
//

import SwiftUI

struct BackgroundView: View {
  @Binding var game: Game
  @Binding var timesPlayed: Double
  @Binding var isButtonActive: Bool
  @Binding var showAlert: Bool
  let resetGameAction: () -> Void
  var body: some View {
    VStack {
      TopView(
        game: $game,
        timesPlayed: $timesPlayed,
        isButtonActive: $isButtonActive,
        showAlert: $showAlert,
        resetGameAction: resetGameAction
      )
      Spacer()
      BottomView(game: $game)
    }
    .padding()
    .background(
      RingsView()
        .disabled(showAlert)
    )
  }
}
struct TopView: View {
  @State private var leaderBoardIsShowing = false
  @Binding var game: Game
  @Binding var timesPlayed: Double
  @Binding var isButtonActive: Bool
  @Binding var showAlert: Bool // Add binding for alert
  let resetGameAction: () -> Void  // Add this closure
  var body: some View {
    HStack {
      RoundedImageViewStroked(systemName: "arrow.counterclockwise") {
        if !showAlert {
          game.resetGameButton()
          print("The previous speed is \(timesPlayed)")
          timesPlayed = 0.02
          print("The the new speed is \(timesPlayed)")
          isButtonActive = true
          resetGameAction()  // Call the closure instead of directly calling resetGame()
        }
      }
      Spacer()
      Button {
        // show leaderboard
        leaderBoardIsShowing = true
      } label: {
        RoundedImageViewFilled(systemname: "list.dash")
      }
    }
    .sheet(isPresented: $leaderBoardIsShowing) {
      LeaderboardView(leaderBoardIsShowing: $leaderBoardIsShowing, game: $game)
    }
  }
}
struct NumberView: View {
  var title: String
  var text: String
  var body: some View {
    VStack(spacing: 5) {
      LabelText(text: title)
        .padding(-2.0)
      RoundRectTextView(text: text)
    }
    .frame(width: Constants.General.roundedViewLength, height: Constants.General.roundRectViewHeight)
  }
}
struct BottomView: View {
  @Binding var game: Game
  var body: some View {
    HStack {
      NumberView(title: "Score", text: String(game.score))
      Spacer()
      NumberView(title: "Round", text: String(game.round))
    }
  }
}
struct RingsView: View {
  @Environment(\.colorScheme)
  var colorScheme: ColorScheme
  var body: some View {
    ZStack {
      Color("BackgroundColor")
        .ignoresSafeArea()
      // ring in the center is .8 opacity
      //      ForEach(1..<6) { ring in
      //        let size = CGFloat(ring * 100)
      //        let ringOpacity = 0.25 - Double(ring) * 0.035
      //        Circle()
      //          .stroke(Color("RingColor"), lineWidth: 20.0)
      //          .frame(width: size, height: size)
      //          .opacity(ringOpacity)
      //      }
      ForEach(1..<6) { ring in
        let size = CGFloat(ring * 100)
        let rOpacity = colorScheme == .dark ? 0.1 : 0.3
        //        RadialGradient(Color("RingColor"), center: .center, startRadius: 100.0, endRadius: 300.0)
        Circle()
          .stroke(lineWidth: Constants.General.circleStrokeWidth)
          .fill(
            RadialGradient(
              gradient: Gradient(colors: [Color("RingColor").opacity(rOpacity * 0.8), Color("RingColor").opacity(0)]),
              center: .center,
              startRadius: 100.0,
              endRadius: 300.0
            ))
          .frame(width: size, height: size)
      }
    }
  }
}
struct BackgroundView_Previews: PreviewProvider {
  static var previews: some View {
    BackgroundView(
      game: .constant(Game()),
      timesPlayed: .constant(0.02),
      isButtonActive: .constant(true),
      showAlert: .constant(true),
      resetGameAction: {}
    )
  }
}
