//
//  Spot.swift
//  Snacktacular
//
//  Created by Richard Shum on 10/31/21.
//

import Foundation
import Firebase

class Spot {
    var name: String
    var address: String
    var averageRating: Double
    var numberOfReviews: Int
    var postingUserID: String
    var documentId: String
    
    var dictionary: [String: Any] {
        return ["name":name, "address":address, "averageRating":averageRating, "numberOfReviews":numberOfReviews, "postingUserID":postingUserID]
    }
    
    init(name: String, address: String, averageRating: Double, numberOfReviews: Int, postingUserID: String, documentID: String) {
        self.name = name
        self.address = address
        self.averageRating = averageRating
        self.numberOfReviews = numberOfReviews
        self.postingUserID = postingUserID
        self.documentId = documentID
    }
    
    convenience init() {
        self.init(name: "", address: "", averageRating: 0.0, numberOfReviews: 0, postingUserID: "", documentID: "")
    }
    
    convenience init(dictionary: [String: Any]){
        let name = dictionary["name"] as! String? ?? ""
        let address = dictionary["address"] as! String? ?? ""
        let averageRating = dictionary["averageRating"] as! Double? ?? 0.0
        let numberOfReviews = dictionary["numberOfReviews"] as! Int? ?? 0
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        self.init(name: name, address: address, averageRating: averageRating, numberOfReviews: numberOfReviews, postingUserID: postingUserID, documentID: "")
    }
    
    func saveData(completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        // Grab the user ID
        guard let postingUserID = Auth.auth().currentUser?.uid else {
            print("ERROR: Could not save data because we don't have a valid postingUserID.")
            return completion(false)
        }
        self.postingUserID = postingUserID
        // Create the dictionary representing data we want to save
        let dataToSave: [String: Any] = self.dictionary
        // If we HAVE saved a record, we will have an ID. Otherwise, .addDocument will create one.
        if self.documentId == "" {
            var ref: DocumentReference? = nil
            ref = db.collection("spots").addDocument(data: dataToSave) { (error) in
                guard error == nil else {
                    print("ERROR: adding document \(error!.localizedDescription)")
                    return completion(false)
                }
                self.documentId = ref!.documentID
                print("Added document: \(self.documentId)") // It worked!
                completion(true)
            }
        } else {
            let ref = db.collection("spots").document(self.documentId)
            ref.setData(dataToSave) { (error) in
                guard error == nil else {
                    print("ERROR: updating document \(error!.localizedDescription)")
                    return completion(false)
                }
                self.documentId = ref.documentID
                print("Updated document: \(self.documentId)") // It worked!
                completion(true)
            }
        }
    }
}
