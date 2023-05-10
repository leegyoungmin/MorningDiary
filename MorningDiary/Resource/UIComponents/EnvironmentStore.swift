//
//  EnvironmentStore.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct BackgroundColor: EnvironmentKey {
  static var defaultValue: Color = Color(uiColor: .secondarySystemBackground)
}

extension EnvironmentValues {
  var backgroundColor: Color {
    get { self[BackgroundColor.self] }
    set { self[BackgroundColor.self] = newValue }
  }
}
