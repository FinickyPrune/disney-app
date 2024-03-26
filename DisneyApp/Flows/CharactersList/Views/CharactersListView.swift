//
//  CharactersListView.swift
//  DisneyApp
//
//  Created by Anastasia Kravchenko on 18.03.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharactersListView: View {

    @ObservedObject
    var viewStore: CharactersListViewStore

    var body: some View {
        Group {
            switch viewStore.state {
            case .initial:
                ProgressView()
                    .progressViewStyle(.circular)
            case let .loaded(data):
                ScrollView {
                    StickyHeader {
                        VStack {
                            if let url = URL(string: data.user.image) {
                                WebImage(url: url)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                Text("Hello, \(data.user.name)!")
                            } else {
                                Image("placeholder")
                                    .resizable()
                                    .scaledToFit()
                                Text("Not Authorized")
                            }
                        }
                    }
                    VStack {
                        ForEach(data.characters, id: \.self) { item in
                            HStack {
                                WebImage(url: URL(string: item.image))
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                Text(item.name)

                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            case .error:
                EmptyView()
            }
        }
        .onAppear { viewStore.loadData() }
    }
}
