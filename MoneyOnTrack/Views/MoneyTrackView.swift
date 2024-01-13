import SwiftUI

struct MoneyTrackView: View {
    @EnvironmentObject var moneyTrack: MoneyTrackData
    @EnvironmentObject var money: Money

    @State private var isAddCategoryPopoverPresented = false
    @State private var isRefreshing = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack {
                        NetWorthCard()
                        AccountList()
                    }
//                    .padding()
                }
                
                // Add Category Button
                Button(action: {
                    isAddCategoryPopoverPresented.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }
                .padding()
                .popover(isPresented: $isAddCategoryPopoverPresented) {
                    AddAccountView()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                //.padding()
            }
            .navigationTitle("Track")
            .MyToolbar()
        }
        .refreshable {
            // Your refresh logic here
            moneyTrack.readFirebase()
            money.getFirebase()
        }
        .environmentObject(moneyTrack)
    }
}

#Preview {
    MoneyTrackView()
        .environmentObject(MoneyTrackData())
}

