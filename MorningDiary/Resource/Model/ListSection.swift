//
//  ListSection.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

enum ListSection: Int, CaseIterable {
  case diary
  case manage
  
  var items: [SectionItem] {
    switch self {
    case .diary:
      return SectionItem.diaryAllItems
    case .manage:
      return SectionItem.managementAllItems
    }
  }
  
  var description: String {
    switch self {
    case .diary:
      return "일기"
    case .manage:
      return "관리"
    }
  }
}
