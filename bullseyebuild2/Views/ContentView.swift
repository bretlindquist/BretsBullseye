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
  @State private var sliderValue: Double = Double.random(in: 1...100)
  @State private var timer: Timer?
  @State private var showAlert: Bool = false
  @State private var increasing: Bool = true
  @State private var timesPlayed: Double = 0.01
  @State private var totalScore: Double = 0
  @State private var setGoal: Int = Int.random(in: 1...100)
  @State private var resultMessage: String = ""
  @State private var oldGoal: Int = 0
  @State private var isButtonActive: Bool = true  // New state variable to control the button's activity
  @State private var isMenuOpen: Bool = false
  @State private var game: Game = Game()
  
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
      VStack {
        
        ZStack {
          VStack(alignment: .center) {
            
           
            InstructionsView(setGoal: $setGoal)
            
            HStack {
              Text("1")
                .foregroundColor(Color("TextColor"))
                .frame(width: 20, height: 20)
                .font(.body)
                .fontWeight(.bold)
              
              Slider(value: $sliderValue, in: 1.0...100.0)
                .bold()
              
              Text("100")
                .frame(width: 40, height: 20)
                .foregroundColor(Color("TextColor"))
              
                .font(.body)
                .fontWeight(.bold)
            }
            
            Button("Hit Me".uppercased())
            {
              self.timer?.invalidate()
              
              oldGoal = setGoal
              setGoal = Int.random(in: 1...100) // Generate new goal for the next round
              self.calcScore()
              
              self.showAlert = true
              
            }
            
            .padding(20.0)
            .background(
              ZStack {
                Color("ButtonColor")
                LinearGradient(
                  gradient: Gradient(colors: [Color.white.opacity(0.3), Color.clear]),
                  startPoint: .top, endPoint: .bottom)
              }
            )
            .foregroundColor(.white)
            .cornerRadius(21)
            .bold()
            .font(.title2)
            
            
            .disabled(!isButtonActive)  // Disable the button based on isButtonActive
            
            //move total score to be on the left side
            Text("Total Score")
              .font(.largeTitle)
              .multilineTextAlignment(.leading)
              .foregroundColor(Color("TextColor"))
            
            
            Text("\(Int(totalScore))")
              .foregroundColor(Color("TextColor"))
            
              .alert(isPresented: $showAlert) {
                Alert(
                  title: Text("Your Score"),
                  message: Text("Goal: \(oldGoal),Sval: \(Int(sliderValue)),Tot: \(Int(totalScore))"),
                  primaryButton: .default(Text("Play Again")) {
                    self.resetGame()
                  },
                  secondaryButton: .cancel(Text("Stop")) {
                    isButtonActive = false
                  }
                )
              }
          }
          //                .blur(radius: isMenuOpen ? 3 : 0)
          //
          //                // Sidebar Menu
          //                if isMenuOpen {
          //                    SidebarMenuView(playAgainAction: {
          //                        resetGame()
          //                        isMenuOpen = false  // Close the menu after playing again
          //                    })
          //                    .frame(width: 250)
          //                    .transition(.move(edge: .leading))
          //            }
        }
        //          .navigationBarHidden(true)
        
        
        
        .onAppear {
          self.resetGame()
        }
      }
    }
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
  
  func resetGame() {
    self.sliderValue = increasing ? 1 : 100
    self.increasing = !increasing
    self.startTimer()
    self.timesPlayed -= 0.0005
    
  }
  
  func startTimer() {
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
}


struct InstructionsView: View {
  @Binding var setGoal: Int
  
  var body: some View {
    InstructionText(text: "Hit the bullseye as close as you can to")
      .padding(.horizontal, 30)
      
    BigNumberView(text: "Goal: \(setGoal)")
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

