//
//  Date + Extension.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation

extension Date {
  static let dateFormatter = DateFormatter()
  
  static func fullDate(with description: String) -> Date? {
    Date.dateFormatter.dateStyle = .medium
    Date.dateFormatter.timeStyle = .none
    
    return Date.dateFormatter.date(from: description)
  }
  
  func description(with dateFormat: String) -> String {
    Date.dateFormatter.dateFormat = dateFormat
    Date.dateFormatter.locale = .current
    
    return Date.dateFormatter.string(from: self)
  }
}
