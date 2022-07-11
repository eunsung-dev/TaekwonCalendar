//
//  ContentView.swift
//  TaekwonCalendar
//
//  Created by 최은성 on 2022/05/11.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var currentDate = Date()
    @EnvironmentObject var contentViewModel: ContentViewModel
    @State private var university = UserDefaults.standard.string(forKey: "university")
    @State private var showingAlert = false

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 20) {
                
                // Custom Date Picker...
                CustomDatePicker(currentDate: $currentDate)
            }
            .padding(.vertical)
        }
        // Safe Area View...
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button {
                    showingAlert = true
                } label: {
                    Text("참여하기")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("Orange"), in: Capsule())
                }
                .alert("참여 확인", isPresented: $showingAlert) {
                    Button("확인", role: .destructive) {
                        contentViewModel.addData(university: university!, date: currentDate)
                    }
                    Button("취소", role: .cancel) {}
                } message: {
                    Text("\(extraDate()[0]) \(extraDate()[1]) \(extraDate()[2])에 참여하시겠습니까?")
                }
//                Button {
//
//                } label: {
//                    Text("Add Remainder")
//                        .fontWeight(.bold)
//                        .padding(.vertical)
//                        .frame(maxWidth: .infinity)
//                        .background(Color("Purple"), in: Capsule())
//                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .foregroundColor(.white)
            .background(.ultraThinMaterial)
        }
    }
    func extraDate()->[String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//        VStack(alignment: .leading) {
//                HStack {
//                    Text("반갑습니다, SSU대학님")
//                        .font(.system(size: 25))
//                    Image("SSU")
//                        .resizable()
//                        .frame(width:30,height: 30)
//            }
//            .padding()
//            VStack {
//                Text("교류전 날짜를 선택해주세요")
//                    .font(.largeTitle)
//                DatePicker("", selection: $date, displayedComponents: .date)
//                    .datePickerStyle(.graphical)
//                    .accentColor(.green)
//                    .environment(\.locale, Locale.init(identifier: "ko"))
//                Text("선택한 날짜는 \(date.formatted(date: .long, time: .omitted))입니다.")
//            }
//            Button(action: {
//
//            }, label: {
//
//            })
//            Spacer()
