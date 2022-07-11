//
//  ContentViewModel.swift
//  TaekwonCalendar
//
//  Created by 최은성 on 2022/07/05.
//

import Foundation
import Firebase
import FirebaseFirestore

class ContentViewModel: ObservableObject {
    @Published var tasks: [TaskMetaData] = [TaskMetaData]()
    @Published var currentPostId: String = ""
    @Published var uploadPostId: String = ""

    //MARK: - 데이터 읽기
    func getData() {
        let db = Firestore.firestore()
        
        db.collection("party").order(by: "date", descending: true).getDocuments { snapshot, error in
            guard error == nil else { return }
            if let snapshot = snapshot {
                DispatchQueue.main.async {
                    self.tasks = snapshot.documents.map { data in
                        var task =  TaskMetaData(id: data.documentID,university: data["university"] as? String ?? "",date: data["date"] as? Date ?? Date())
                        let postTimeStamp = data["date"] as? Timestamp
                        task.date = postTimeStamp?.dateValue() ?? Date()
                        //                        print("posts: \(self.posts)")
                        return task
                    }
                }
            } else {
                // error
                // snapshot이 없음.
            }
        }
        
    }
    
    //MARK: - 데이터 쓰기
    func addData(university: String, date: Date) {
        let db = Firestore.firestore()
        let ref = db.collection("party").document()
        let id = ref.documentID
        
        ref.setData(["id": id, "university": university, "date": date]) { error in
            guard error == nil else { return }
        }
        self.getData()
    }
}
