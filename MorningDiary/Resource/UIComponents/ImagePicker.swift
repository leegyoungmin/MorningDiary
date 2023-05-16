//
//  ImagePicker.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import PhotosUI

protocol Coordinator: AnyObject { }

protocol ImagePickerDelegate: AnyObject {
  func imagePickerDelegate(picker: Self, didFinishPicking result: UIImage...)
}

struct ImagePickerView: UIViewControllerRepresentable {
  @Binding var selectedImages: [Photo]
  let isCamera: Bool
  
  func makeUIViewController(context: Context) -> UIViewController {
    if isCamera {
      let controller = configurationCameraViewController()
      controller.delegate = context.coordinator
      return controller
    } else {
      let controller = configurationImagePickerViewController()
      controller.delegate = context.coordinator
      return controller
    }
  }
  
  private func configurationImagePickerViewController() -> PHPickerViewController {
    var configuration = PHPickerConfiguration()
    configuration.selectionLimit = 5
    configuration.filter = .images
    
    let controller = PHPickerViewController(configuration: configuration)
    controller.isEditing = true
    
    return controller
  }
  
  private func configurationCameraViewController() -> UIImagePickerController {
    let controller = UIImagePickerController()
    controller.sourceType = .camera
    controller.cameraCaptureMode = .photo
    controller.cameraDevice = .rear
    controller.allowsEditing = true
    
    return controller
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
  
  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate {
    let parent: ImagePickerView
    
    init(parent: ImagePickerView) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      picker.dismiss(animated: true)
      guard let editedImage = info[.editedImage] as? UIImage else { return }
      let photo = Photo(image: editedImage)
      parent.selectedImages.append(photo)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      picker.dismiss(animated: true)
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


