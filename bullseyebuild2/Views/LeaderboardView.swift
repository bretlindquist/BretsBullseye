//
//  RowView.swift
//  bullseyebuild2
//
//  Created by Bret Allan Lindquist on 2/4/24.
//

import SwiftUI


struct LeaderboardView: View {
  @Binding var leaderBoardIsShowing: Bool
  @Binding var game: Game
  var body: some View {
    ZStack {
      Color("BackgroundColor")
        .ignoresSafeArea()
      VStack(spacing: 10) {
        HeaderView(leaderBoardIsShowing: $leaderBoardIsShowing)
        LabelView()
        ScrollView {
          VStack(spacing: 10) {
            ForEach(game.leaderboardEntries.indices, id: \.self) { index in
              let leaderboardEntry = game.leaderboardEntries[index]
              RowView(index: index + 1, score: leaderboardEntry.score, date: leaderboardEntry.date)
            }
          }
        }
      }
    }
  }
}
struct HeaderView: View {
  @Binding var leaderBoardIsShowing: Bool
  @Environment(\.verticalSizeClass)
  var verticalSizeClass: UserInterfaceSizeClass?
  @Environment(\.horizontalSizeClass)
  var horizontalSizeClass: UserInterfaceSizeClass?
  var body: some View {
    ZStack {
      HStack {
        BigBoldText(text: "Leaderboard")
        if verticalSizeClass == .regular && horizontalSizeClass == .compact {
          Spacer()
        }
      }
      HStack {
        Spacer()
        Button {
          leaderBoardIsShowing.toggle()
        } label: {
          RoundedImageViewFilled(systemname: "xmark")
        }
      }
    }
    .padding([.top, .horizontal])
  }
}
struct LabelView: View {
  var body: some View {
    HStack {
      Spacer()
        .frame(width: Constants.General.roundedViewLength)
      Spacer()
      LabelText(text: "Score")
        .frame(width: Constants.Leaderboard.scoreColumnWidth)
      Spacer()
      LabelText(text: "Date")
        .frame(width: Constants.Leaderboard.dateColumnWidth)
      Spacer()
    }
    .padding(.horizontal)
    .frame(maxWidth: Constants.Leaderboard.maxRowWidth)
  }
}
struct RowView: View {
  let index: Int
  let score: Int
  let date: Date
  var body: some View {
    VStack {
      HStack {
        RoundedTextView(text: String(index))
        Spacer()
        ScoreText(score: score)
          .frame(width: Constants.Leaderboard.scoreColumnWidth)
        Spacer()
        DateText(date: date)
          .frame(width: Constants.Leaderboard.dateColumnWidth)
      }
      .background(
        RoundedRectangle(cornerRadius: .infinity)
          .stroke(Color("LeaderboardRowColor"), lineWidth: Constants.General.strokeWidth)
      )
      .padding(.horizontal)
      .frame(maxWidth: Constants.Leaderboard.maxRowWidth)
    }
  }
}

struct RowView_Previews: PreviewProvider {
  static private var leaderBoardIsShowing = Binding.constant(false)
  static private var game = Binding.constant(Game(loadTestData: true))

  static var previews: some View {
    LeaderboardView(leaderBoardIsShowing: leaderBoardIsShowing, game: game)
    LeaderboardView(leaderBoardIsShowing: leaderBoardIsShowing, game: game)
      .previewInterfaceOrientation(.landscapeRight)
      .preferredColorScheme(.dark)
  }
}
