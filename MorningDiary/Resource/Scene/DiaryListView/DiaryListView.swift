//
//  DiaryListView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DiaryListView: View {
  @Binding var selectedItem: SectionItem?
  private let listSections = ListSection.allCases
  
  @ViewBuilder private func sectionLabel(with item: SectionItem) -> some View {
    if item.imageName.isEmpty {
      Label(item.description, systemImage: item.imageName)
        .labelStyle(.titleOnly)
    }
    
    if item.imageName.isEmpty == false {
      Label(item.description, systemImage: item.imageName)
        .labelStyle(.titleAndIcon)
    }
  }
  
  var body: some View {
    List(listSections, id: \.rawValue) { listSection in
      MODADisclosureGroup {
        Text(listSection.description)
          .font(.system(size: 24, weight: .bold))
      } content: {
        ForEach(listSection.items, id: \.rawValue) { sectionChild in
          ListSectionChildView(selectedItem: $selectedItem, sectionChild: sectionChild)
        }
      }
      .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
  }
}

private extension DiaryListView {
  struct ListSectionChildView: View {
    @Binding var selectedItem: SectionItem?
    let sectionChild: SectionItem
    
    var body: some View {
      MODAButton {
        withAnimation {
          selectedItem = sectionChild
        }
      } label: {
        Label(sectionChild.description, systemImage: sectionChild.imageName)
      }
      .foregroundColor(selectedItem == sectionChild ? Color("AccentLabelColor") : Color("LabelColor"))
      .padding(12)
      .background(selectedItem == sectionChild ? Color.accentColor : .white)
      .cornerRadius(10)
    }
  }
}

struct DiaryListView_Previews: PreviewProvider {
  static var previews: some View {
    DiaryBoardView()
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
