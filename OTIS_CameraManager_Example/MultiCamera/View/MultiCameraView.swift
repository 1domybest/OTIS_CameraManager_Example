//
//  MultiCameraView.swift
//  Example
//
//  Created by 온석태 on 10/25/24.
//

import Foundation
import SwiftUI

import CameraManagerFrameWork

struct MultiCameraView: View {
    @ObservedObject var vm: MultiCameraViewModel = MultiCameraViewModel()
    
    var body: some View {
        ZStack {
            UIKitViewRepresentable(view: vm.cameraMananger?.multiCameraView)
                .frame(height: (UIScreen.main.bounds.width / 9)  * 16 )
                .overlay(
                    VStack {
                        Spacer().frame(height: 10)
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                self.vm.toggleTorch()
                            }, label: {
                                Text("Torch \(self.vm.isTorchOn ? "OFF" : "ON")")
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(self.vm.isTorchOn ? .black : .red)
                                    )
                            })
                        }
                        
                        Spacer()
                        
                        VStack {
                            HStack {
                                Text("UV Exposure Control")
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(.orange)
                                    )
                                Spacer()
                            }
                            Spacer().frame(height: 10)
                            
                            Slider(value: $vm.brightness, in: -8...8, step: 0.1)
                                
                        }.frame(width: UIScreen.main.bounds.width - 30)
                    
                        
                        
                        Spacer().frame(height: 20)
                        
                        HStack {
                            VStack {
                                Button(action: {
                                    self.vm.toggleCamera(showThumbnail: true)
                                }, label: {
                                    Text("Camera \(self.vm.isCameraOn ? "OFF With Thumbnail" : "ON")")
                                        .foregroundColor(.white)
                                        .bold()
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(self.vm.isCameraOn ? .black : .red)
                                        )
                                    
                                })
                                
                                Spacer().frame(height: 20)
                                
                                Button(action: {
                                    self.vm.toggleThumbnail()
                                }, label: {
                                    Text("Thumbnail \(self.vm.isShowThumnnail ? "OFF" : "Show")")
                                        .foregroundColor(.white)
                                        .bold()
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(self.vm.isShowThumnnail ? .blue : .red)
                                        )
                                })
                                Spacer().frame(height: 10)
                            }
                            
                            Spacer()
                            
                            VStack {
                                
                                Button(action: {
                                    self.vm.toggleCameraScreenMode()
                                }, label: {
                                    Text("\(self.vm.currentScreenMode == .doubleScreen ? "SingleScreen" : "DoubleScreen")")
                                        .foregroundColor(self.vm.currentScreenMode == .doubleScreen ? .white : .black)
                                        .bold()
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(self.vm.currentScreenMode == .doubleScreen ? .black : .white)
                                        )
                                })
                                
                                Spacer().frame(height: 10)
                                
                                Button(action: {
                                    self.vm.toggleMainCameraPosition()
                                }, label: {
                                    
                                    Text("MainCamera [\(self.vm.isFrontMainCamera ? "Front" : "Back")]")
                                        .foregroundColor(self.vm.isFrontMainCamera ? .white : .black)
                                        .bold()
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(self.vm.isFrontMainCamera ? .black : .white)
                                        )
                                })
                            }
                          
                            
                            Spacer().frame(width: 10)
                        }
                        
                       
                    }
                )
                .onChange(of: vm.brightness) { value in
                    self.vm.changeExposure()
                }
        }
        .onDisappear {
            self.vm.unrference()
        }
    }
}
