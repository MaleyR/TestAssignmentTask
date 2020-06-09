//
//  VoiceGenerator.swift
//  TestAssignmentTask
//
//  Created by Ruslan Maley on 06.06.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation
import AVFoundation

class VoiceGenerator: NSObject {
    private var completionHandler: (() -> Void)?
    private let synthesizer = AVSpeechSynthesizer()
    
    func readText(_ text: String, completion: @escaping (() -> Void)) {
        self.completionHandler = completion
        synthesizer.delegate = self
        let utterance = AVSpeechUtterance(string: text)
        let voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.voice = voice
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }
}

extension VoiceGenerator: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        completionHandler?()
    }
}
