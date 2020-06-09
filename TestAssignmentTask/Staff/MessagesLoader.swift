//
//  MessagesLoader.swift
//  TestAssignmentTask
//
//  Created by Ruslan Maley on 06.06.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

class MessagesLoader {
    static func loadMessages(completion: @escaping (([Message]) -> Void)) {
        DispatchQueue.global().async {
            guard let url = Bundle.main.url(forResource: "Chat Scenario", withExtension: "json") else { return }
            do {
                let data = try Data(contentsOf: url)
                
                let jsonDecoder = JSONDecoder()
                
                let decoded = try jsonDecoder.decode([Message].self, from: data)
                completion(decoded)
            } catch {
                
            }
        }
    }
}
