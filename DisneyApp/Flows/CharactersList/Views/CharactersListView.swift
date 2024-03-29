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
                        self.headerView(
                            image: data.user.image,
                            name: data.user.name
                        )
                        .frame(maxWidth: .infinity)
                        .padding()
                        .padding(.top, Const.headerTopPadding)
                    }
                    self.listView(items: data.characters)
                    .padding()
                    .background(
                        RoundedRectangle(
                            cornerRadius: Const.cornerRadius
                        )
                        .fill(Color.white)
                        .shadow(radius: Const.shadowRadius)
                    )
                }
                .ignoresSafeArea(edges: .bottom)
                .background(
                    Color.green.opacity(
                        Const.backgroundOpacity
                    )
                    .ignoresSafeArea(edges: .top)
                )
                .scrollIndicators(.hidden)

            case .error:
                EmptyView()
            }
        }
        .onAppear { viewStore.loadData() }
    }

    @ViewBuilder
    private func headerView(
        image: String,
        name: String
    ) -> some View {
        VStack {
            if let url = URL(string: image) {
                WebImage(url: url)
                    .resizable()
                    .frame(
                        width: Const.avatarWidth,
                        height: Const.avatarHeight
                    )
                    .clipShape(Circle())
                Text(Const.greetingText.replacingOccurrences(
                    of: Const.textPlaceholder,
                    with: name
                ))
                .padding(.vertical)
            } else {
                Image(Const.placholderImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: Const.placholderWidth,
                        height: Const.placholderHeight
                    )
                    .clipped()
                Text(Const.notAuthorized)
            }
        }
    }

    @ViewBuilder
    private func listView(
        items: [CharactersListViewStore.State.Data.Character]
    ) -> some View {
        VStack {
            ForEach(items, id: \.self) { item in
                HStack {
                    WebImage(url: URL(string: item.image))
                        .resizable()
                        .frame(
                            width: Const.imageWidth,
                            height: Const.imageHeight
                        )
                        .clipShape(Circle())
                    Text(item.name)

                    Spacer()
                }
            }
        }
    }
}

private enum Const {
    static let avatarWidth: CGFloat = 120
    static let avatarHeight: CGFloat = 120
    static let placholderWidth: CGFloat = 300
    static let placholderHeight: CGFloat = 150
    static let headerTopPadding: CGFloat = 30
    static let imageWidth: CGFloat = 80
    static let imageHeight: CGFloat = 80
    static let cornerRadius: CGFloat = 20
    static let shadowRadius: CGFloat = 8
    static let backgroundOpacity: CGFloat = 0.2
    static let notAuthorized: String = "Not Authorized"
    static let placholderImageName: String = "placeholder"
    static let greetingText: String = "Hello, %@!"
    static let textPlaceholder: String = "%@"
}
