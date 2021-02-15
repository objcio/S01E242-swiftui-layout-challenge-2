//
//  ContentView.swift
//  Bars
//
//  Created by Chris Eidhof on 08.02.21.
//

import SwiftUI

// Idea: https://twitter.com/danfishgold/status/1347312839669800963

struct WidthKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func measureWidth(_ f: @escaping (CGFloat) -> ()) -> some View {
        overlay(GeometryReader { proxy in
            Color.clear.preference(key: WidthKey.self, value: proxy.size.width)
        }
        .onPreferenceChange(WidthKey.self, perform: f))
    }
}

struct Row: View {
    var value: CGFloat
    @State var width: CGFloat = 0
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Start").fixedSize()
                Spacer()
                Text("End Label With a bit more text in it").fixedSize()
            }
            .lineLimit(1)
            Color.red
                .frame(width: value * width, height: 10)
        }
        .frame(width: value * width, alignment: .leading)
        .frame(maxWidth: .infinity, alignment: .leading)
        .measureWidth { self.width = $0 }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0...9, id: \.self) { ix in
                Row(value: CGFloat(ix)/10)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().frame(width: 200)
    }
}
