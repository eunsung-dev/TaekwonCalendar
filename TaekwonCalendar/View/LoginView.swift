//
//  LoginView.swift
//  TaekwonCalendar
//
//  Created by 최은성 on 2022/07/05.
//

import SwiftUI

struct LoginView: View {
    @State private var recognizedText = "Tap button to start scanning"
    @State private var showingScanningView = false
    @State private var showingContentView = false
    @State private var university = UserDefaults.standard.string(forKey: "university")
    
    var body: some View {
        if !showingContentView {
            NavigationView {
                VStack {
                    Image("taekwondo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding()
                    
                    Text("다른 대학교와 교류전을 손쉽게!")
                    
                    Button(action: {
                        self.showingScanningView = true
                    }, label: {
                        Text("학생증으로 로그인하기")
                    })
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.white)
                    .border(.black, width: 3)
//                    Button(action: {
//
//                    }, label: {
//                        Text("모바일 학생증으로 인증하기")
//                    })
//                    .padding()
//                    Button(action: {
//
//                    }, label: {
//                        Text("학교 웹메일로 인증하기")
//                    })
//                    .padding()
//
//                    ScrollView {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 20, style: .continuous)
//                                .fill(Color.gray.opacity(0.2))
//
//                            Text(recognizedText)
//                                .padding()
//                        }
//                        .padding()
//                    }

                }
                .onChange(of: recognizedText, perform: {newValue in
                    // 학생증일 경우
                    if recognizedText.contains("UNIVERSITY") {
                        print("학생증임을 확인했습니다.")
                        showingContentView = true
                        if recognizedText.contains("SOONGSIL") {
                            print("숭실대학생입니다.")
                            UserDefaults.standard.set("SOONGSIL",forKey: "university")
                        }
                    }
                })
                .sheet(isPresented: $showingScanningView) {
                    ScanDocumentView(recognizedText: self.$recognizedText)
                }
            }
        }
        else {
            ContentView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
