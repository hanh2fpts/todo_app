//
//  TodoWidgetBundle.swift
//  TodoWidget
//
//  Created by HaNH on 05/06/2023.
//

import WidgetKit
import SwiftUI

@main
struct TodoWidgetBundle: WidgetBundle {
    var body: some Widget {
        TodoWidget()
        TodoWidgetLiveActivity()
    }
}
