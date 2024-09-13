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
    public var messages: [Message] = []
    public var subscriptions: [Subscription] = []
    
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
        userRef.child(id).observeSingleEvent(of: .value) { snapshot in
            if let dict = snapshot.value as? [String: Any]? {
                self.user = User(dict!)
                self.getMessages()
                self.setupFreeLeftMessages()
            }
        }
    }
    
    func updateUser(){
        let id = user?.id.replacingOccurrences(of: ".", with: "_") ?? ""
        userRef.child(id).updateChildValues(user?.dictToSave() ?? [:])
    }

    func setupFreeLeftMessages(){
        let id = user?.id.replacingOccurrences(of: ".", with: "_") ?? ""
        guard let freeSubs = subscriptions.first(where: {$0.id == "free"}), var user = user else { return }
        let fullTwelveHoursCount = self.user?.free?.subscriptionEnds.fullTwelveHourIntervals() ?? 0
        user.leftMessage +=  fullTwelveHoursCount * freeSubs.messageCount
        user.free?.subscriptionEnds = (self.user?.free?.subscriptionEnds ?? "").addTwelveHours(fullTwelveHoursCount+1)
        userRef.child(id).updateChildValues(user.dictToSave())
    }
        
    func getSubscriptions(){
        Database.database().reference().child("subscriptions").observeSingleEvent(of: .value) { snapshot in
            let dict = snapshot.value as? [[String: Any]?]
            self.subscriptions = dict?.map({Subscription($0 ?? [:])}) ?? []
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
    
    func getFavTherapists() -> [Therapist] {
        if therapists.isEmpty || Defaults.favoritedTherapists.isEmpty { return [] }
        return Defaults.favoritedTherapists.compactMap({getTherapist(id: $0)})
    }
    
    func getThreads() -> [Therapist] {
        let ids = Set(messages.map({$0.threadId}))
        return therapists.filter { ids.contains($0.id) }
    }
    
    func getMessages(){
        let savedMessages = readMessagesFromFile()
        self.messages = savedMessages.map { Message($0) }
    }
    
    func getThreadMessage(threadId: Int) -> [Message]{
        return self.messages.filter({$0.threadId == threadId}).sorted(by: {$0.datetime > $1.datetime})
    }
    
    func saveUser(_ user: User) -> String {
        let id = user.id.replacingOccurrences(of: ".", with: "_")
        let freeSubs = subscriptions.first(where: {$0.id == "free"})
        var user = user
        user.free = UserSubscription(id: "free", messageCount: freeSubs?.messageCount ?? 10, subscriptionEnds: Date().ISO8601Format())
        
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
    
    func saveMessage(msg: Message){
        messages.append(msg)
        let messagesArray = messages.compactMap { $0.getDictionary }
        writeMessagesToFile(messages: messagesArray)
    }
    
    private func getTag(id: Int) -> Tag? {
        return tags.first(where: {$0.id == id })
    }
    
    private func getTherapist(id: Int) -> Therapist? {
        return therapists.first(where: {$0.id == id })
    }
    
    private func getMessagesFileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("messages.txt")
    }
    
    private func readMessagesFromFile() -> [[String: Any]] {
        let fileURL = getMessagesFileURL()

        if let data = try? Data(contentsOf: fileURL),
           let json = try? JSONSerialization.jsonObject(with: data, options: []),
           let messagesArray = json as? [[String: Any]] {
            return messagesArray
        } else {
            return []
        }
    }

    private func writeMessagesToFile(messages: [[String: Any]]) {
        let fileURL = getMessagesFileURL()

        if let data = try? JSONSerialization.data(withJSONObject: messages, options: .prettyPrinted) {
            try? data.write(to: fileURL)
        }
    }
}
