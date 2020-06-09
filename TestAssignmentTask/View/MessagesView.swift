//
//  MessagesView.swift
//  TestAssignmentTask
//
//  Created by Ruslan Maley on 08.06.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import SwiftUI

struct MessagesView: View {
    @ObservedObject var viewModel: MessagesViewModel
    
    var body: some View {
        MessagesScrollView {
            ForEach(self.viewModel.messages, id: \.self) { message in
                Bubble(message: message, shouldMoveUp: self.viewModel.messages.count > 1)
            }
        }
        .background(Color(red: 249 / 255, green: 250 / 255, blue: 251 / 255))
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .onAppear() {
            self.viewModel.shouldStartProcessing()
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(viewModel: MessagesViewModel())
    }
}
