//
//  SectionItem.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

enum SectionItem: Int, CaseIterable {
  case date
  case recent
  case saved
  case notification
  
  static let diaryAllItems: [SectionItem] = [.date, .recent, .saved]
  static let managementAllItems: [SectionItem] = [.notification]
  
  var description: String {
    switch self {
    case .date:
      return "날짜별로"
    case .recent:
      return "최근 목록"
    case .saved:
      return "저장된 항목"
    case .notification:
      return "알림 설정"
    }
  }
  
  var imageName: String {
    switch self {
    case .date:
      return "calendar"
    case .recent:
      return "clock"
    case .saved:
      return "bookmark"
    case .notification:
      return ""
    }
  }
}
