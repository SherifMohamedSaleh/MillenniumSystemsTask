//
//  FilterViewModel.swift
//  MillenniumSystemsTask
//
//  Created by Sherif Abd El-Moniem on 21/08/2023.
//

import Foundation
import SwiftUI

class FilterViewModel : ObservableObject {
  
    @Published var image: Image?
    @Published var filterIntensity = 0.5
    @Published var showingImagePicker = false
    @Published var processedImage: UIImage?
    @Published var inputImage: UIImage?
    
    @Published var bottomSheet = false
    @Published var addNewBox = false


    @Published var textBoxes : [TextBox]  = [TextBox]()
    
    // Current index
    @Published var currentIndex: Int = 0

    // Save the view frame size
    @Published var rect: CGRect = .zero
    
    // selected filter
    @Published var currentFilter: CIFilter = CIFilter.sepiaTone()

    @Published var showAlert = false
    @Published var message = ""
    
    let context = CIContext()
    
    // list of applied filters
    var ciFilterList = [
        FilterModel(name: "Spiaton", value: CIFilter.sepiaTone()),
        FilterModel(name: "Mono", value: CIFilter.photoEffectMono()),
        FilterModel(name: "Blur", value: CIFilter.boxBlur()),
        FilterModel(name: "Noir", value: CIFilter.photoEffectNoir()),
        FilterModel(name: "Fade", value: CIFilter.photoEffectFade()),
        FilterModel(name: "Chrome", value: CIFilter.photoEffectChrome()),
        FilterModel(name: "Process", value: CIFilter.photoEffectProcess()),
        FilterModel(name: "Transfer", value: CIFilter.photoEffectTransfer()),
        FilterModel(name: "Instant", value: CIFilter.photoEffectInstant()),
        FilterModel(name: "Vignette", value: CIFilter.vignette()),
        FilterModel(name: "IPixellate", value: CIFilter.pixellate()),
        FilterModel(name: "UnsharpMask", value: CIFilter.unsharpMask()) ,
        FilterModel(name: "Tonal", value: CIFilter.photoEffectTonal())
    ]
    
    
    func getIndex(textBox: TextBox) -> Int {
          textBoxes.firstIndex { $0.id == textBox.id } ?? 0
    }
    
    func showOnImagePicker(){
        self.showingImagePicker = true
    }
    
    func showFiltersBottomSheetView(){
        self.bottomSheet.toggle()
    }
    
    
    func showAddTextBottomSheetView(){
        
        // Create one new box
          textBoxes.append(TextBox())

        // Update index
          currentIndex = textBoxes.count - 1
        self.addNewBox.toggle()
    }
    func cancelTextView() {
        addNewBox = false
        // Avoiding the removal of already added
        if !textBoxes[currentIndex].isAdded {
            
            textBoxes.removeLast()
            currentIndex = textBoxes.count - 1
        }
    }
    
    
    func loadImage() {
        guard let inputImage =   inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
          currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys =   currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {   currentFilter.setValue(  filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) {   currentFilter.setValue(  filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) {   currentFilter.setValue(  filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage =   currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
              image = Image(uiImage: uiImage)
              processedImage = uiImage
        }
    }

    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }

    func saveButtonAction()  {
        
        guard let processedImage = self.processedImage else { return }

        // Generate image from both canvas and our textboxes view
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        processedImage.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: rect.size))
 
        // Draw text boxes
        let SwiftUIView = ZStack {
            ForEach(textBoxes) { [self] textBox in
                Text(
                    textBoxes[currentIndex].id == textBox.id && addNewBox
                        ? ""
                        : textBox.text
                )
      
                .font(.system(size: textBox.textSize))
                .foregroundColor(textBox.textColor)
                .offset(textBox.offset)
            }
        }
        
        let controller = UIHostingController(rootView: SwiftUIView).view!
        controller.frame = rect
        controller.backgroundColor = .clear
        controller.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), afterScreenUpdates: true)
        
        // Get image
        let generatedImage = UIGraphicsGetImageFromCurrentImageContext()
        // End render
        UIGraphicsEndImageContext()

        if let image = generatedImage?.pngData() {
            // save image as PNG to photo library
            UIImageWriteToSavedPhotosAlbum(UIImage(data: image)!, nil, nil, nil)
            
            message = "Image Saved successfully!"
            showAlert.toggle()
        }
    }

}
