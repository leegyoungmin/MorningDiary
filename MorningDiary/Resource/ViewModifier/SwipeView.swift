//
//  SwipeView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

typealias Leading<V> = Group<V> where V: View
typealias Trailing<V> = Group<V> where V: View

enum SwipeState: Equatable {
  case untouched
  case swipe(UUID)
}

struct SwipeView<LeadingContent: View, TrailingContent: View>: ViewModifier {
  enum VisibleButton {
    case none
    case left
    case right
  }
  
  @GestureState private var isDragged: Bool = false
  @State private var offsetX: CGFloat = .zero
  @Binding private var state: SwipeState
  @State var visibleButton: VisibleButton = .none
  
  @State private var maxLeadingOffset: CGFloat = .zero
  @State private var minTrailingOffset: CGFloat = .zero
  @State private var oldOffset: CGFloat = .zero
  
  let backgroundColor: Color
  let leadingView: Group<LeadingContent>?
  let trailingView: Group<TrailingContent>?
  
  private let id = UUID()
  
  init(
    backgroundColor: Color,
    state: Binding<SwipeState>,
    swipeItemsView: @escaping () -> TupleView<(Leading<LeadingContent>, Trailing<TrailingContent>)>
  ) {
    self.backgroundColor = backgroundColor
    self._state = state
    self.leadingView = swipeItemsView().value.0
    self.trailingView = swipeItemsView().value.1
  }
  
  init(
    backgroundColor: Color,
    state: Binding<SwipeState>,
    trailingView: @escaping () -> TrailingContent
  ) {
    self.backgroundColor = backgroundColor
    self._state = state
    self.leadingView = nil
    self.trailingView = Group { trailingView() }
    self.minTrailingOffset = -90
  }
  
  init(
    backgroundColor: Color,
    state: Binding<SwipeState>,
    leadingView: @escaping () -> LeadingContent
  ) {
    self.backgroundColor = backgroundColor
    self._state = state
    self.leadingView = Group { leadingView() }
    self.trailingView = nil
    self.maxLeadingOffset = 90
  }
  
  func reset() {
    visibleButton = .none
    oldOffset = .zero
    offsetX = .zero
  }
  
  func gestureContent(content: Content) -> some View {
    content
      .tag(id)
      .contentShape(Rectangle())
      .offset(x: offsetX)
      .gesture(
        DragGesture(minimumDistance: 15, coordinateSpace: .local)
          .updating($isDragged) { value, state, transaction in
            state = true
          }
          .onChanged { value in
            let totalSlide = value.translation.width + oldOffset
            
            if ((0...Int(maxLeadingOffset)) ~= Int(totalSlide)) || ((Int(minTrailingOffset)...0) ~= Int(totalSlide)) {
              withAnimation {
                offsetX = totalSlide
              }
            }
          }
          .onEnded { value in
            withAnimation {
              if visibleButton == .left, value.translation.width < -20 {
                reset()
              } else if visibleButton == .right, value.translation.width > 20 {
                reset()
              } else if offsetX > 25 || offsetX < -25 {
                if offsetX > 0 {
                  visibleButton = .left
                  offsetX = maxLeadingOffset
                } else {
                  visibleButton = .right
                  offsetX = minTrailingOffset
                }
                
                oldOffset = offsetX
              } else {
                reset()
              }
            }
          }
      )
      .onChange(of: isDragged) { newValue in
        if newValue == false, visibleButton == .none {
          withAnimation {
            reset()
          }
        }
        state = newValue ? .swipe(id) : .untouched
      }
      .onChange(of: state) { newValue in
        switch newValue {
        case .swipe(let tag):
          if id != tag, visibleButton != .none {
            withAnimation {
              reset()
            }
            
            state = .untouched
          }
        default:
          break
        }
      }
  }
  
  func body(content: Content) -> some View {
    ZStack(alignment: .center) {
      backgroundColor
      
      HStack(alignment: .center) {
        if let leadingView = leadingView {
          leadingView
            .frame(width: 90)
            .padding(.leading)
            .offset(x: (-90 + offsetX))
        }
        
        Spacer()
        
        if let trailingView = trailingView {
          trailingView
            .frame(width: 90)
            .padding(.trailing)
            .offset(x: (90 + offsetX))
        }
      }
      .font(.title)
      
      gestureContent(content: content)
    }
  }
}

extension View {
  @ViewBuilder
  func addSwipeActions<V1: View, V2: View>(
    backgroundColor: Color,
    state: Binding<SwipeState> = .constant(.untouched),
    @ViewBuilder content: @escaping () -> TupleView<(Leading<V1>, Trailing<V2>)>
  ) -> some View {
    self.modifier(SwipeView(backgroundColor: backgroundColor, state: state, swipeItemsView: content))
  }
  
  @ViewBuilder
  func addSwipeAction<SwipeContent: View>(
    backgroundColor: Color,
    state: Binding<SwipeState> = .constant(.untouched),
    edge: HorizontalAlignment,
    @ViewBuilder content: @escaping () -> SwipeContent
  ) -> some View {
    switch edge {
    case .leading:
      self.modifier(SwipeView<SwipeContent, EmptyView>(backgroundColor: backgroundColor, state: state, leadingView: content))
    default:
      self.modifier(SwipeView<EmptyView, SwipeContent>(backgroundColor: backgroundColor, state: state, trailingView: content))
    }
  }
}
