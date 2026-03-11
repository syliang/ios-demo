import SwiftUI

struct HomeView: View {
    var onLogout: () -> Void

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .foregroundStyle(.green)
                Text("You're logged in!")
                    .font(.title2.bold())
                Text("Welcome back, user@example.com")
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Log Out", role: .destructive) {
                        onLogout()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(onLogout: {})
}
