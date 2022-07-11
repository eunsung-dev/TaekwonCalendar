//
//  CustomDatePicker.swift
//  TaekwonCalendar
//
//  Created by 최은성 on 2022/05/11.
//

import SwiftUI
import FirebaseFirestore

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    
    // Month update on arrow button clicks...
    @State var currentMonth: Int = 0
    
    @EnvironmentObject var contentViewModel: ContentViewModel
    @State private var university = UserDefaults.standard.string(forKey: "university")
    
    var students: [Student] = [Student(eng: "SOONGSIL", kor: "숭실")]
    
    var body: some View {
        VStack(spacing: 35) {
            // Days...
            let days: [String] = ["일","월","화","수","목","금","토"]
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        if let index = students.firstIndex(where: { $0.eng == "SOONGSIL" }) {
                            Text("반가워요, " + students[index].kor)
                                .fontWeight(.semibold)
                        }
                        Image(university!)
                            .resizable()
                            .frame(width: 25, height: 25)

                    }
                    
                    Text(extraDate()[0] + " " + extraDate()[1])
                        .font(.title.bold())
                }
                Spacer()
                
                Button(action: {
                    withAnimation{
                        currentMonth -= 1
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                })
                Button(action: {
                    withAnimation{
                        currentMonth += 1
                    }
                }, label: {
                    Image(systemName: "chevron.right")
                })
                
            }
            .padding(.horizontal)
            
            // Day View...
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            //Dates...
            // Lazy Grid...
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15) {
                
                ForEach(extractDate()) {value in
                    
                    CardView(value: value)
                        .background(
                        
                            Capsule()
                                .fill(Color.pink)
                                .padding(.horizontal, 8)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
            VStack(spacing: 15) {
                Text("참여 대학")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 20)

                if let task = contentViewModel.tasks.first(where: {task in
                    return isSameDay(date1: task.date, date2: currentDate)
                }) {
                    ScrollView {
                        ForEach(contentViewModel.tasks) {(data: TaskMetaData) in
                            if isSameDay(date1: data.date, date2: currentDate) {
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    // For Custom Timing...
//                                    Text("날짜")
                                    HStack {
                                        if let index = students.firstIndex(where: { $0.eng == "SOONGSIL" }) {
                                            Text(students[index].kor+"대학교")
                                                .font(.title2.bold())
                                        }
                                        Image(data.university)
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                    }
                                }
                                .padding(.vertical, 20)
                                .padding(.horizontal)
//                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(

                                    Color("lightGrey")
                                        .opacity(0.5)
                                        .cornerRadius(10)
                                        .clipShape(Capsule())
                                )
                            }
                        }
                    }
                }
                else {
                    Text("참여한 대학이 없습니다.")
                }
            }
            .padding()
        }
        .onAppear {
            contentViewModel.getData()
        }
        .onChange(of: currentMonth) { newValue in
                
            // updating Month...
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue)->some View{
        
        VStack {
            
            if value.day != -1 {
                if let task = contentViewModel.tasks.first(where: { task in
                    
                    return isSameDay(date1: task.date, date2: value.date)
                }) {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)

                    Spacer()
                    
                    Circle()
                        .fill(isSameDay(date1: task.date, date2: currentDate) ? .white : Color.pink)
                        .frame(width: 8, height: 8)
                }
                else {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)

                    Spacer()
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
    }
    
    // checking dates...
    func isSameDay(date1: Date, date2: Date)->Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // extrating Year And Month for display...
    func extraDate()->[String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth()->Date{
        let calendar = Calendar.current

        // Getting Current Month Date...
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate()->[DateValue]{
        let calendar = Calendar.current

        // Getting Current Month Date...
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            // getting day...
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Extending Date to get Current Month Dates...
extension Date {
    
    func getAllDates()->[Date] {
        let calendar = Calendar.current
        
        // getting start Date...
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month],from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        // getting date
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
