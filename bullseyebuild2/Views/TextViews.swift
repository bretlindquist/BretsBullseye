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
    Text("🎯🎯🎯")
      .font(.largeTitle)
      .padding(.bottom, 5.0)
    Text(text.uppercased())
      .fontWeight(.bold)
    //                .foregroundColor(Color(hue: 1.0, saturation: 0.739, brightness: 0.676))
      .multilineTextAlignment(.center)
      .bold()
      .lineSpacing(4.0)
      .font(.title)
      .kerning(2)
    .foregroundColor(Color("TextColor"))  }
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
struct TextViews_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      InstructionText(text: "Instructions")
      BigNumberView(text: "Goal: 999")
    }
    }
}
