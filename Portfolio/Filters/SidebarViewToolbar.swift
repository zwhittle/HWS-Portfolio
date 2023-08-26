//
//  SidebarViewToolbar.swift
//  Portfolio
//
//  Created by Zach Whittle on 8/26/23.
//

import SwiftUI

struct SidebarViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @State private var showingAwards = false

    var body: some View {
        Button(action: dataController.newTag) {
            Label("Add tag", systemImage: "plus")
        }

        Button {
            showingAwards.toggle()
        } label: {
            Label("Show Awards", systemImage: "rosette")
        }
        .sheet(isPresented: $showingAwards, content: AwardsView.init)

        #if DEBUG
        Button {
            dataController.deleteAll()
            dataController.createSampleData()
        } label: {
            Label("ADD SAMPLE DATA", systemImage: "flame")
        }
        #endif
    }
}

#Preview {
    SidebarViewToolbar()
}
