//
//  ImageFilter.swift
//  MillenniumSystemsTask
//
//  Created by Sherif Abd El-Moniem on 21/08/2023.
//


import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

@available(iOS 14.0, *)
struct ImageFilter: View {
    
    @ObservedObject var vm = FilterViewModel()
    
    
    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: [.cyan , .purple, .purple , .cyan]), center: .topLeading).ignoresSafeArea()
            VStack {
                
                // this view check if there is selected image or not
                // in case of selected image display it
                // in case of not display select image button
                imageOrButton
                
                
                if vm.bottomSheet {
                    // filter scrolling slider
                    filtersAction
                }
                
            }
            // imagePicker sheet
            .sheet(isPresented: $vm.showingImagePicker, onDismiss: vm.loadImage) {
                ImagePicker(image: self.$vm.inputImage)
            }
            .alert(isPresented: $vm.showAlert) {
                Alert(
                    title: Text("Add Image"),
                    message: Text(vm.message),
                    dismissButton: .destructive(Text("OK"))
                )
            }
            // add text view
            if vm.addNewBox  && vm.image != nil   {
                addTextView
            }
        }.onAppear{
            print("onAppear")
        }
        
    }
    
    @ViewBuilder var addTextView : some View {
        ZStack  {
            Color.black.opacity(0.75)
                .ignoresSafeArea()
            VStack{
                // TextField
                TextField("Type here...", text: $vm.textBoxes[vm.currentIndex].text)
                    .font(.system(size: vm.textBoxes[vm.currentIndex].textSize))
                    .colorScheme(.dark)
                    .foregroundColor(vm.textBoxes[vm.currentIndex].textColor)
                    .padding()
                if vm.textBoxes[vm.currentIndex].text.count > 0{
                    HStack {
                        Text("size")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        
                        Slider(value:  $vm.textBoxes[vm.currentIndex].textSize  , in: 20...80)
                        
                    }.padding([.leading , .trailing ] , 20)
                }
            }
            // Add and cancel button
            HStack {
                Button(action: {
                    // toggle the isAdded
                    vm.textBoxes[vm.currentIndex].isAdded = true
                    
                    withAnimation {
                        vm.addNewBox = false
                    }
                }, label: {
                    Text("Add")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding()
                })
                Spacer()
                Button(action: vm.cancelTextView) {
                    Text("Cancel")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .overlay(
                HStack(spacing: 2) {
                    ColorPicker("", selection: $vm.textBoxes[vm.currentIndex].textColor)
                        .labelsHidden()
                    Text("Color")
                        .fontWeight(.light)
                        .foregroundColor(.white)
                }
            ) .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    
    @ViewBuilder var  filtersAction : some View  {
        let intensity = Binding<Double>(
            get: {
                self.vm.filterIntensity
            },
            set: {
                self.vm.filterIntensity = $0
                self.vm.applyProcessing()
            }
        )
        VStack {
            if vm.image != nil {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(vm.ciFilterList , id: \.self.name) { filter in
                            
                            VStack(alignment: .leading) {
                                
                                Text(filter.name)
                                    .foregroundColor( filter.value == vm.currentFilter ?.blue : .white)
                                    .padding()
                                    .font(.body)
                                    .border(filter.value == vm.currentFilter ?.blue : .white, width: 2)
                                
                                
                            }
                            .padding(.leading, 15)
                            .onTapGesture {
                                print(filter.name)
                                self.vm.setFilter(filter.value!)
                            }
                        }
                    }
                }.padding([.top , .bottom] , 10 )
                HStack {
                    if vm.image != nil {
                        Text("Intensity")
                            .foregroundColor(.white)
                        
                        Slider(value: intensity)
                    }
                }.padding([.leading , .trailing ] , 20)
            }
        }.background(Color.black.opacity(0.75))
    }
    
    
    @ViewBuilder var  imageOrButton : some View {
        if vm.image != nil {
            GeometryReader { geometry -> AnyView in
                 let rect = geometry.frame(in: .global)
                DispatchQueue.main.async {
                    if vm.rect == .zero {
                        vm.rect = rect
                    }
                }
                return AnyView(
                    ZStack{
                        vm.image?
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                            .shadow(radius: 10)
                            .scaledToFit()
                        
                        // list of added text to display
                        listOfTexts
                        
                        // positiond view with text , filter , save buttons
                        positionsActionView
                    }
                )
            }
        } else {
            Button(action: vm.showOnImagePicker , label: {
                Text("Tap to select a picture")
                    .foregroundColor(.black)
                    .padding()
                    .font(.title).border(Color.black, width: 2)
            })
        }
    }
    
    var positionsActionView : some View{
        VStack{
            Button {
                vm.showAddTextBottomSheetView()
            } label: {
                VStack{
                    Image(systemName: "t.square")
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                    Text("Text")
                }
            }.padding()
            
            
            Button {
                vm.showFiltersBottomSheetView()
            } label: {
                VStack{
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                    Text("Filter")
                }
            }.padding()
            Button {
                
                vm.saveButtonAction()
                print("Edit button was tapped")
            } label: {
                VStack{
                    Image(systemName: "tray.and.arrow.down"  )
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                    Text("Save")
                }
            }.padding()
        }     .background(Color.black.opacity(0.75))
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .position(x:UIScreen.main.bounds.size.width - 40 , y: 300)
    }
    
    
    var listOfTexts : some View {
        ForEach(vm.textBoxes) { textBox in
            Text(
                vm.textBoxes[vm.currentIndex].id == textBox.id && vm.addNewBox
                ? ""
                : textBox.text
            )
            
            .font(.system(size: textBox.textSize))
            .foregroundColor(textBox.textColor)
            .offset(textBox.offset)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        let current = value.translation
                        // Add with last offset
                        let lastOffset = textBox.lastOffset
                        let newTranslation = CGSize(
                            width: lastOffset.width + current.width,
                            height: lastOffset.height + current.height
                        )
                        
                        vm.textBoxes[vm.getIndex(textBox: textBox)].offset = newTranslation
                    })
                    .onEnded({ value in
                        // Save the last offset for exact drag position
                        vm.textBoxes[vm.getIndex(textBox: textBox)].lastOffset = value.translation
                    })
            )
            .onLongPressGesture  {
                
                vm.currentIndex = vm.getIndex(textBox: textBox)
                withAnimation {
                    vm.addNewBox = true
                }
            }
            
        }
    }
}

@available(iOS 14.0, *)
struct ImageFilter_Previews: PreviewProvider {
    static var previews: some View {
        ImageFilter()
    }
}

