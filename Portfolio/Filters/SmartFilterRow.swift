//
//  SmartFilterRow.swift
//  Portfolio
//
//  Created by Zach Whittle on 8/26/23.
//

import SwiftUI

struct SmartFilterRow: View {
    var filter: Filter

    var body: some View {
        NavigationLink(value: filter) {
            Label(LocalizedStringKey(filter.name), systemImage: filter.icon)
        }
    }
}

#Preview {
    SmartFilterRow(filter: Filter.all)
}
