//
//  TapView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

enum ToggleState: Equatable {
  case selected(UUID)
  case unSelected
}

struct ToggleView: ViewModifier {
  @State private var isTouched: Bool = false
  @Binding var toggleState: ToggleState
  private let tintColor: Color = .accentColor
  private let id = UUID()
  
  init(toggleState: Binding<ToggleState>) {
    _toggleState = toggleState
  }
  
  func body(content: Content) -> some View {
    content
      .background(toggleState == .unSelected && isTouched == false ? .white : tintColor)
      .tag(id)
      .onTapGesture {
        isTouched.toggle()
      }
      .onChange(of: isTouched) { newValue in
        if newValue {
          toggleState = .selected(id)
        } else {
          toggleState = .unSelected
        }
      }
      .onChange(of: toggleState) { newValue in
        switch newValue {
        case .selected(let tag):
          if id != tag {
            toggleState = .unSelected
            isTouched = false
          }
        default:
          break
        }
      }
  }
}

extension View {
  @ViewBuilder
  func addToggleAction(state: Binding<ToggleState>) -> some View {
    self.modifier(ToggleView(toggleState: state))
  }
}
