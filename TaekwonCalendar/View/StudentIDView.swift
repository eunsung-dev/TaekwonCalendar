//
//  StudentIDView.swift
//  TaekwonCalendar
//
//  Created by 최은성 on 2022/07/06.
//

import SwiftUI

struct StudentIDView: View {
    
    @State private var recognizedText = "Tap button to start scanning"
    @State private var showingScanningView = false
    

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.gray.opacity(0.2))
                        
                        Text(recognizedText)
                            .padding()
                    }
                    .padding()
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.showingScanningView = true
                    }) {
                        Text("Start Scanning")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Capsule().fill(Color.blue))
                }
                .padding()
            }
            .navigationBarTitle("Text Recognition")
            .sheet(isPresented: $showingScanningView) {
                ScanDocumentView(recognizedText: self.$recognizedText)
            }
        }
    }
}

struct StudentIDView_Previews: PreviewProvider {
    static var previews: some View {
        StudentIDView()
    }
}
