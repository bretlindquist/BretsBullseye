//
//  RoundedViews.swift
//  bullseyebuild2
//
//  Created by Bret Allan Lindquist on 2/2/24.
//
// arrow.counterclockwise
// list.dash

import SwiftUI

struct RoundedRectangleView: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 20)
      .strokeBorder(Color("ButtonStrokeColor"), lineWidth: Constants.General.strokeWidth)
      .frame(width: 70, height: 60)
  }
}
struct RoundedImageViewStroked: View {
  var systemName: String
  var action: () -> Void  // The action is a closure that takes no parameters and returns nothing
  var body: some View {
    Button(action: action) {  // Use the action in the Button initializer
      Image(systemName: systemName)
        .font(.title)
        .foregroundColor(Color("TextColor"))
        .frame(width: Constants.General.roundedViewLength, height: Constants.General.roundRectViewHeight)
        .overlay(
          Circle()
            .strokeBorder(Color("ButtonStrokeColor"), lineWidth: Constants.General.strokeWidth)
        )
    }
  }
}
struct RoundedImageViewFilled: View {
  var systemname: String
  var body: some View {
    Image(systemName: systemname)
      .font(.title)
      .foregroundColor(Color("ButtonFilledTextColor"))
      .frame(width: Constants.General.roundedViewLength, height: Constants.General.roundRectViewHeight)
      .background(
        Circle()
          .fill(Color("ButtonFilledBackgroundColor"))
      )
  }
}
struct RoundRectTextView: View {
  var text: String
  var body: some View {
    Text(text)
      .frame(width: Constants.General.roundRectViewWidth, height: Constants.General.roundRectViewHeight)
      .font(.title3)
      .kerning(-0.2)
      .bold()
      .foregroundColor(Color("TextColor"))
      .overlay(
        RoundedRectangle(cornerRadius: Constants.General.roundRectCornerRadius)
          .stroke(lineWidth: 2)
          .foregroundColor(Color("ButtonStrokeColor"))
      )
  }
}

struct RoundedTextView: View {
  var text: String
  var body: some View {
    // put a circle around this
    Text(text)
      .bold()
      .font(.title3)
      .foregroundColor(Color("TextColor"))
      .frame(width: Constants.General.roundedViewLength, height: Constants.General.roundRectViewHeight)
      .overlay(
        Circle()
          .strokeBorder(Color("LeaderboardRowColor"), lineWidth: Constants.General.strokeWidth)
      )
  }
}

struct PreviewSFImagesView: View {
  var body: some View {
    VStack(spacing: 10) {
      RoundedImageViewFilled(systemname: "arrow.counterclockwise")
      RoundedImageViewStroked(systemName: "list.dash") {
        print("nothing")
      }
      RoundedRectangleView()
      RoundedRectangleView()
      RoundRectTextView(text: "100")
      RoundedTextView(text: "1")
    }
  }
}

struct RoundedViews_Previews: PreviewProvider {
  static var previews: some View {
    PreviewSFImagesView()
      .preferredColorScheme(.light)
    PreviewSFImagesView()
      .previewDevice("iPhone 14 Pro Max")
      .preferredColorScheme(.dark)
  }
}
