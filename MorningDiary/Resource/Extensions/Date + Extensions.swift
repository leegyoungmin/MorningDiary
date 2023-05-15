//
//  Date + Extension.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation

extension Date {
  static let dateFormatter = DateFormatter()
  
  func description(with dateFormat: String) -> String {
    Date.dateFormatter.dateFormat = dateFormat
    Date.dateFormatter.locale = .current
    
    return Date.dateFormatter.string(from: self)
  }
}
