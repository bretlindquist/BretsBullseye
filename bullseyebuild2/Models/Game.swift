//
//  Game.swift
//  bullseyebuild2
//
//  Created by Bret Allan Lindquist on 1/24/24.
//

import Foundation

struct Game {
  var leaderboardEntries: [LeaderBoardEntry] = []
  var score: Int = 0
  var round: Int = 1
  init(loadTestData: Bool = false) {
    if loadTestData {
      addToLeaderboard(score: 100)
      addToLeaderboard(score: 50)
      addToLeaderboard(score: 50)
      addToLeaderboard(score: 50)
      addToLeaderboard(score: 50)
    }
  }
  func points(oldGoal: Int, sliderValue: Int) -> Int {
      let difference = abs(oldGoal - sliderValue)
      if difference == 0 {
          return 100 // Bullseye hit grants 100 points
      } else if difference <= 10 {
          return 11 - difference // Gives points in the range 1 to 10 for being 10 to 1 away, respectively
      } else {
          return 0 // No points if the difference is greater than 10
      }
  }
  mutating func resetGameButton() {
    round = 1
    score = 0
  }
  mutating func startNewRound(points: Int) {
    addToLeaderboard(score: points)
    round += 1
    score += points
//    target = Int.random(in: 1...100)
  }
  mutating func addToLeaderboard(score: Int) {
    leaderboardEntries.append(LeaderBoardEntry(score: score, date: Date()))
    leaderboardEntries.sort { entry1, entry2 in
      entry1.score > entry2.score
    }
  }
}

struct LeaderBoardEntry {
  let score: Int
  let date: Date
}
