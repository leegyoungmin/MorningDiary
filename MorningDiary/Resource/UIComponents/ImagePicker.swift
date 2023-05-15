//
//  ImagePicker.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
  @Binding var selectedImages: [Photo]
  
  func makeUIViewController(context: Context) -> some UIViewController {
    var configuration = PHPickerConfiguration()
    configuration.selectionLimit = 5
    configuration.filter = .images
    
    let controller = PHPickerViewController(configuration: configuration)
    controller.isEditing = true
    controller.delegate = context.coordinator
    
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    let parent: ImagePicker
    
    init(parent: ImagePicker) {
      self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      picker.dismiss(animated: true)
      
      results.forEach {
        $0.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
          if let image = object as? UIImage {
            let photo = Photo(image: image)
            withAnimation {
              self.parent.selectedImages.append(photo)
            }
          }
        }
      }
    }
  }
}
