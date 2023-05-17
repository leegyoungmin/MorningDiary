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
      PlainDisclosureGroup {
        Text(listSection.description)
          .font(.system(size: 24, weight: .bold))
      } content: {
        ForEach(listSection.items, id: \.rawValue) { sectionItem in
          DiaryListSectionButton {
            withAnimation {
              self.selectedItem = sectionItem
            }
          } label: {
            sectionLabel(with: sectionItem)
          }
          .foregroundColor(selectedItem == sectionItem ? Color("AccentLabelColor") : Color("LabelColor"))
          .padding(12)
          .background(selectedItem == sectionItem ? Color.accentColor : .white)
          .cornerRadius(10)
        }
      }
      .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
  }
}

private extension DiaryListView {
  struct DiaryListSectionButton<Label: View>: View {
    let action: () -> Void
    let label: () -> Label
    
    init(_ action: @escaping () -> Void, label: @escaping () -> Label) {
      self.action = action
      self.label = label
    }
    
    var body: some View {
      HStack {
        label()
        
        Spacer()
      }
      .frame(maxWidth: .infinity)
      .contentShape(RoundedRectangle(cornerRadius: 10))
      .onTapGesture {
        withAnimation {
          action()
        }
      }
    }
  }
}

struct DiaryListView_Previews: PreviewProvider {
  static var previews: some View {
    DiaryBoardView()
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
