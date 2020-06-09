//
//  MessagesViewModel.swift
//  TestAssignmentTask
//
//  Created by Ruslan Maley on 06.06.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import SwiftUI

class MessagesViewModel: ObservableObject {
    @Published private(set) var messages: [Message] = []
    
    private var internalMessages: [Message] = []
    
    private let voiceGenerator = VoiceGenerator()
    
    private var currentIndex: Int = 0
    
    func shouldStartProcessing() {
        MessagesLoader.loadMessages { [unowned self] (messages) in
            DispatchQueue.main.async {
                self.internalMessages = messages
                self.processCurrentMessage()
            }
        }
    }
}

// MARK: - Showing processing
private extension MessagesViewModel {
    func processCurrentMessage() {
        guard currentIndex < internalMessages.count else { return }
        
        let message = internalMessages[currentIndex]
        showMessage(message: message)
    }
    
    func processNextMessage() {
        currentIndex += 1
        processCurrentMessage()
    }
    
    func showMessage(message: Message) {
        messages.append(message)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.showingAnimationTime) {
            self.playMessage(message: message)
        }
    }
    
    func playMessage(message: Message) {
        voiceGenerator.readText(message.text) { [unowned self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.sleepTimeForNextBubble) {
                self.processNextMessage()
            }
        }
    }
}
