//
//  FirestoreManager.swift
//  AITherapist
//
//  Created by Shirin-Yan on 15.08.2024.
//

import Foundation
import Firebase

class FirestoreManager {
    
    static let shared = FirestoreManager()
    public var user: User?
    public var tags: [Tag] = []
    public var therapists: [Therapist] = []
    
    private let userRef = Database.database().reference().child("users")
    private let therapistRef = Database.database().reference().child("therapists")
    private let tagRef = Database.database().reference().child("tags")

    func getData(){
        getUser(id: Defaults.token)
        getTherapists { _ in }
        getTags { _ in }
    }
    
    func getUser(id: String) {
        let id = id.replacingOccurrences(of: ".", with: "_")
        print(id)
        userRef.child(id).observeSingleEvent(of: .value) { snapshot in
            if let dict = snapshot.value as? [String: Any]? {
                self.user = User(dict!)
            }
        }
    }
    
    func saveUser(_ user: User) -> String {
        let id = user.id.replacingOccurrences(of: ".", with: "_")
        
        userRef.child(id).observeSingleEvent(of: .value) { snapshot in
            if let dict = snapshot.value as? [String: Any]? {
                self.user = User(dict!)
            } else {
                let userDict = user.dictToSave()
                self.userRef.child(id).setValue(userDict)
                self.user = user
            }
        }
        
        return id
    }
    
    func getTherapists(completion: @escaping ([Therapist])->()){
        therapistRef.observeSingleEvent(of: .value) { snapshot in
            var dict = snapshot.value as? [[String: Any]?]
            dict?.removeAll(where: {$0 == nil})
            dict?.forEach({ therapistDict in
                let tagIds = therapistDict!["tags"] as? [Int] ?? []
                let tags = tagIds.map({self.getTag(id: $0)!})
                self.therapists = dict?.map({Therapist($0!, tags: tags)}) ?? []
                completion(self.therapists)
            })
        }
    }
    
    func getTags(completion: @escaping ([Tag])->()){
        tagRef.observeSingleEvent(of: .value) { snapshot in
            var dict = snapshot.value as? [[String: Any]?]
            dict?.removeAll(where: {$0 == nil})
            self.tags = dict?.map({Tag($0!)}) ?? []
            completion(self.tags)
        }
    }
    
    func getTag(id: Int) -> Tag? {
        return tags.first(where: {$0.id == id })
    }
}
