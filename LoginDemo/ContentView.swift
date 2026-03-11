import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            HomeView(onLogout: { isLoggedIn = false })
        } else {
            LoginView(onLogin: { isLoggedIn = true })
        }
    }
}

#Preview {
    ContentView()
}
