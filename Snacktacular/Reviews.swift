//
//  Reviews.swift
//  Snacktacular
//
//  Created by Richard Shum on 11/8/21.
//

import Foundation
import Firebase

class Reviews {
    var reviewArray:  [Review] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
        
    }
}
