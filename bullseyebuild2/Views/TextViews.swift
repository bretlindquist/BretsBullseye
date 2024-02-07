//
//  TextViews.swift
//  bullseyebuild2
//
//  Created by Bret Allan Lindquist on 2/1/24.
//

import SwiftUI

struct InstructionText: View {
  var text: String
  var body: some View {
    Text(text.uppercased())
      .fontWeight(.bold)
      .multilineTextAlignment(.center)
      .bold()
      .font(.title3)
      .kerning(2)
    .foregroundColor(Color("TextColor"))  }
}


struct SliderLabelText: View {
  var text: String
  var body: some View {
    Text(text)
      .foregroundColor(Color("TextColor"))
    //      .frame(width: 20, height: 20)
      .font(.body)
      .fontWeight(.bold)
  }
}

struct BigNumberView: View {
  var text: String
  var body: some View {
    Text(text)
      .font(.largeTitle)
      .fontWeight(.black)
      .foregroundColor(Color("TextColor"))
  }
}
struct TotalScoreTextViews: View {
  var text: String
  var body: some View {
    Text(text)
      .font(.title2)
      .multilineTextAlignment(.leading)
      .foregroundColor(Color("TextColor"))
  }
}
struct CurrentScoreView: View {
  var text: String
  var body: some View {
    Text(text)
      .foregroundColor(Color("TextColor"))
  }
}
struct LabelText: View {
  var text: String
  var body: some View {
    Text(text.uppercased())
      .foregroundColor(Color("TextColor"))
      .bold()
      .kerning(1.5)
      .font(.caption)
  }
}
struct BodyText: View {
  var text: String
  var body: some View {
    Text(text)
      .font(.subheadline)
      .fontWeight(.semibold)
      .multilineTextAlignment(.center)
      .lineSpacing(12)
  }
}
struct ScoreText: View {
  var score: Int
  var body: some View {
    Text(String(score))
      .bold()
      .kerning(-0.2)
      .foregroundColor(Color("TextColor"))
      .font(.title3)
  }
}

struct DateText: View {
  var date: Date
  var body: some View {
    Text(date, style: .time)
      .bold()
      .kerning(-0.2)
      .foregroundColor(Color("TextColor"))
      .font(.title3)
//      Text(date, style: .date) // i want this to display Time / Date but for the scope of this assignment i'm leaving it for now
  }
}

struct ButtonText: View {
  var text: String
  var body: some View {
    Text(text)
      .foregroundColor(.white)
      .font(.title3)
      .bold()
        .padding()
      .frame(maxWidth: .infinity)
      .background(
        Color.accentColor
          .cornerRadius(15)
      )
  }
}

struct BigBoldText: View {
  let text: String
  var body: some View {
    Text(text.uppercased())
      .font(.title)
      .fontWeight(.black)
      .kerning(2.0)
      .foregroundColor(Color("TextColor"))
  }
}

struct PreviewInstructionsView: View {
  var body: some View {
    VStack {
      InstructionText(text: "Instructions")
      BigNumberView(text: "Goal: 999")
      SliderLabelText(text: "1-100")
      TotalScoreTextViews(text: "Total Score")
      LabelText(text: "Label")
      BodyText(text: "You scored 200\n👏👏👏")
      ButtonText(text: "Start New Round")
      ScoreText(score: 459)
      DateText(date: Date())
      BigBoldText(text: "Leaderboard")
    }
    .padding()
  }
}

struct TextViews_Previews: PreviewProvider {
  static var previews: some View {
    PreviewInstructionsView()
    PreviewInstructionsView()
      .previewDevice("iPhone 14 Pro Max")
      .preferredColorScheme(.dark)
  }
}
