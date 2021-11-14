//
//  Photos.swift
//  Snacktacular
//
//  Created by Richard Shum on 11/14/21.
//

import Foundation
import Firebase

class Photos {
    var photoArray:  [Photo] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
        
    }
    
    func loadData(spot:Spot, completed: @escaping () -> ()) {
        guard spot.documentID != "" else {
            return
            
        }
        db.collection("spots").document(spot.documentID).collection("photos").addSnapshotListener { (QuerySnapshot, error) in
            guard error == nil else {
                print("ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.photoArray = []
            for document in QuerySnapshot!.documents {
                let photo = Photo(dictionary: document.data())
                photo.documentID = document.documentID
                self.photoArray.append(photo)
            }
            completed()
        }
    }
}
