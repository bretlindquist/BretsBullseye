//
//  bullseyebuild2Tests.swift
//  bullseyebuild2Tests
//
//  Created by Bret Allan Lindquist on 2/3/24.
//

import XCTest
@testable import bullseyebuild2
// swiftlint:disable:next attributes
var game: Game!

final class Bullseyebuild2Tests: XCTestCase {
  override func setUpWithError() throws {
    game = Game()
  }

  override func tearDownWithError() throws {
    game = nil
  }

  func testExample() throws {
    //      XCTAssertEqual(game.points(oldGoal: 5, sliderValue: 50), 999)
  }

  func testNewRound() {
    game.startNewRound(points: 100)
    XCTAssertEqual(game.score, 100)
    XCTAssertEqual(game.round, 2)
  }
  func testLeaderBoard() {
    game.startNewRound(points: 100)
    XCTAssertEqual(game.leaderboardEntries.count, 1)
    XCTAssertEqual(game.leaderboardEntries[0].score, 100)
    game.startNewRound(points: 200)
    XCTAssertEqual(game.leaderboardEntries.count, 2)
    XCTAssertEqual(game.leaderboardEntries[0].score, 200)
    XCTAssertEqual(game.leaderboardEntries[0].score, 100)
  }
}
