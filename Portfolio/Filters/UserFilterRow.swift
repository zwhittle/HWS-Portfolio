//
//  UserFilterRow.swift
//  Portfolio
//
//  Created by Zach Whittle on 8/26/23.
//

import SwiftUI

struct UserFilterRow: View {
    var filter: Filter
    var rename: (Filter) -> Void
    var delete: (Filter) -> Void

    var body: some View {
        NavigationLink(value: filter) {
            Label(filter.name, systemImage: filter.icon)
                .badge(filter.activeIssuesCount)
                .contextMenu {
                    Button {
                        rename(filter)
                    } label: {
                        Label("Rename", systemImage: "pencil")
                    }

                    Button {
                        delete(filter)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .accessibilityElement()
                .accessibilityLabel(filter.name)
                .accessibilityHint("^\(filter.activeIssuesCount) issues")
        }
    }
}

#Preview {
    UserFilterRow(filter: Filter.all, rename: {_ in }, delete: {_ in})
}
