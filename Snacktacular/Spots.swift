//
//  Spots.swift
//  Snacktacular
//
//  Created by Richard Shum on 11/1/21.
//

import Foundation
import Firebase

class Spots {
    var spotArray: [Spot] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("spots").addSnapshotListener { (QuerySnapshot, error) in
            guard error == nil else {
                print("ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.spotArray = []
            for document in QuerySnapshot!.documents {
                let spot = Spot(dictionary: document.data())
                spot.documentId = document.documentID
                self.spotArray.append(spot)
            }
            completed()
        }
    }
}
