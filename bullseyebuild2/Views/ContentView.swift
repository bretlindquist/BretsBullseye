//
//  ContentView.swift
//  bullseyebuild2
//
//  Created by Bret Allan Lindquist on 1/23/24.
//

//
//  ContentView.swift
//  Bullseye
//
//  Created by Bret Allan Lindquist on 1/22/24.
//

import SwiftUI

struct ContentView: View {
  @State private var sliderValue = Double.random(in: 1...100)
  @State private var timer: Timer?
  @State private var showAlert = false
  @State private var increasing = true
  @State private var timesPlayed: Double = 0.02
  @State private var totalScore: Double = 0
  @State private var setGoal = Int.random(in: 1...100)
  @State private var resultMessage: String = ""
  @State private var oldGoal: Int = 0
  @State private var isButtonActive = true  // New state variable to control the button's activity
  @State private var isMenuOpen = false
  @State private var game = Game()
  init() {
    let label = UILabel()
    label.text = "🎯"
    label.font = UIFont.systemFont(ofSize: 30)
    label.sizeToFit() // Ensure the label size fits the emoji
    let renderer = UIGraphicsImageRenderer(size: label.bounds.size)
    let image = renderer.image { context in
      label.layer.render(in: context.cgContext)
    }
    UISlider.appearance().setThumbImage(image, for: .normal)
  }
  var body: some View {
    ZStack {
      Color("BackgroundColor")
        .ignoresSafeArea()
      BackgroundView(
        game: $game,
        timesPlayed: $timesPlayed,
        isButtonActive: $isButtonActive,
        showAlert: $showAlert,
        resetGameAction: {
          timesPlayed = 0.02
          self.startTimer()
          isButtonActive = true
        }
      )
      VStack {
        Spacer()

        InstructionsView(setGoal: $setGoal)
          .padding(.top, showAlert ? 0 : 50)
          .padding(.bottom, -10.0)
        if showAlert {
          ZStack {
            PointsView(
              game: $game,
              showAlert: $showAlert,
              oldGoal: $oldGoal,
              sliderValue: $sliderValue,
              resetGame: resetGame)
              .transition(.scale)
          }
        } else {
          HitMeButtonView(
            sliderValue: $sliderValue,
            oldGoal: $oldGoal,
            setGoal: $setGoal,
            isButtonActive: $isButtonActive,
            timer: $timer,
            showAlert: $showAlert,
            totalScore: $totalScore,
            timesPlayed: $timesPlayed,
            game: $game)
            .transition(.scale)
            .padding(.top, 30)
        }
        Spacer()
        //              .alert(isPresented: $showAlert) {
        //                Alert(
        //                  title: Text("Your Score"),
        //                  message: Text("Goal: \(oldGoal),Sval: \(Int(sliderValue)),Tot: \(Int(totalScore))"),
        //                  primaryButton: .default(Text("Play Again")) {
        //                    self.resetGame()
        //                    print("The current score is: \(game.score)")
        //
        //                  },
        //                  secondaryButton: .cancel(Text("Stop")) {
        //                    isButtonActive = false
        //                  }
        //                )
        //              }


      }
      .padding(.top, -10)
      .onAppear {
        self.resetGame()
      }
      if !showAlert {
        SliderView(sliderValue: $sliderValue)
          .zIndex(1)
          .transition(.scale)
      }
    }
  }

  func startTimer() {
    timer?.invalidate()  // Invalidate the existing timer

    self.timer = Timer.scheduledTimer(withTimeInterval: timesPlayed, repeats: true) { _ in
      DispatchQueue.main.async {
        if self.increasing {
          self.sliderValue += 1
          if self.sliderValue >= 100 {
            self.increasing = false
          }
        } else {
          self.sliderValue -= 1
          if self.sliderValue <= 1 {
            self.increasing = true
          }
        }
      }
    }
  }
  func resetGame() {
    self.sliderValue = increasing ? 1 : 100
    self.increasing = !increasing
    self.startTimer()
    self.timesPlayed -= 0.0015
  }
}
struct SliderView: View {
  @Binding var sliderValue: Double
  var body: some View {
    HStack {
      SliderLabelText(text: "1")
        .frame(width: 35)
      Slider(value: $sliderValue, in: 1.0...100.0)
      SliderLabelText(text: "100")
        .frame(width: 35)
    }
    .padding()
  }
}

struct InstructionsView: View {
  @Binding var setGoal: Int
  var body: some View {
    InstructionText(text: "🎯🎯🎯\nHit the bullseye as close as you can to")
    BigNumberView(text: "Goal: \(setGoal)")
  }
}
struct TotalView: View {
  @Binding var totalScore: Double
  var body: some View {
    TotalScoreTextViews(text: "Total Score")
    CurrentScoreView(text: "\(Int(totalScore))")
  }
}

struct HitMeButtonView: View {
  @Binding var sliderValue: Double
  @Binding var oldGoal: Int
  @Binding var setGoal: Int
  @Binding var isButtonActive: Bool
  @Binding var timer: Timer?
  @Binding var showAlert: Bool
  @Binding var totalScore: Double
  @Binding var timesPlayed: Double
  @Binding var game: Game
  var body: some View {
    Button("Hit Me".uppercased()) {
      self.timer?.invalidate()
      oldGoal = setGoal
      setGoal = Int.random(in: 1...100) // Generate new goal for the next round
      self.calcScore()
      withAnimation {
        self.showAlert = true
      }
      //      game.startNewRound(points: game.points(oldGoal: oldGoal, sliderValue: Int(sliderValue)))
      let pointsAwarded = game.points(
        oldGoal: oldGoal,
        sliderValue: Int(sliderValue
      ))
      print(
        "oldGoal: \(oldGoal) setGoal: \(setGoal) Points for this round: \(pointsAwarded) sliderValue: \(sliderValue) "
      )

      game.startNewRound(points: pointsAwarded)
      print("Total score after round: \(game.score)") // Debugging line to check score update
    }

    .padding(20.0)
    .background(
      ZStack {
        Color("ButtonColor")
        LinearGradient(
          gradient: Gradient(colors: [Color.white.opacity(0.3), Color.clear]),
          startPoint: .top,
          endPoint: .bottom)
      }
    )
    .overlay(
      RoundedRectangle(cornerRadius: Constants.General.roundRectCornerRadius)
        .strokeBorder(Color.white, lineWidth: Constants.General.strokeWidth)
    )
    .foregroundColor(.white)
    .cornerRadius(21)
    .bold()
    .font(.title2)
    .disabled(!isButtonActive)  // Disable the button based on isButtonActive
  }
  func calcScore() {
    let difference = abs(oldGoal - Int(sliderValue))  // Calculate the absolute difference
    print("difference: \(difference)")
    if difference == 0 {
      // Award 100 points for an exact match
      totalScore += 100
      print("Exact match! Added 100, total score: \(totalScore)")
    } else if difference < 10 && difference != 0 {
      // Points decrease as the difference increases, up to 10
      let points = 10 - difference
      totalScore += Double(points)
      print("Close! Added \(points), total score: \(totalScore)")
    } else {
      // No points added if the difference is more than 10
      print("No points added, total score remains: \(totalScore)")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
    ContentView()
      .previewDevice("iPhone 14 Pro Max")
      .preferredColorScheme(.dark)
  }
}
