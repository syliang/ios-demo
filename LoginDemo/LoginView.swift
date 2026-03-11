import SwiftUI

// MARK: - Color palette

private extension Color {
    static let cream      = Color(red: 0.929, green: 0.910, blue: 0.875)  // background
    static let navy       = Color(red: 0.118, green: 0.169, blue: 0.290)  // heading text
    static let gold       = Color(red: 0.788, green: 0.659, blue: 0.298)  // accent
    static let muted      = Color(red: 0.455, green: 0.431, blue: 0.396)  // secondary text
    static let fieldLine  = Color(red: 0.788, green: 0.659, blue: 0.298).opacity(0.4)
    static let cardFill   = Color(red: 0.965, green: 0.953, blue: 0.933)
}

// MARK: - Underline text field

private struct UnderlineField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        VStack(spacing: 6) {
            Group {
                if isSecure {
                    SecureField("", text: $text)
                } else {
                    TextField("", text: $text)
                }
            }
            .placeholder(when: text.isEmpty) {
                Text(placeholder)
                    .tracking(2)
                    .font(.system(size: 12, weight: .light))
                    .foregroundStyle(Color.muted)
            }
            .font(.system(size: 16, weight: .light))
            .foregroundStyle(Color.navy)
            .autocapitalization(.none)
            .disableAutocorrection(true)

            Rectangle()
                .fill(Color.fieldLine)
                .frame(height: 1)
        }
    }
}

private extension View {
    func placeholder<Content: View>(when show: Bool, @ViewBuilder content: () -> Content) -> some View {
        ZStack(alignment: .leading) {
            if show { content() }
            self
        }
    }
}

// MARK: - Lune illustration (pure SwiftUI)

private struct LuneView: View {
    var body: some View {
        ZStack {
            // Ripple rings
            ForEach([1.0, 0.75, 0.5], id: \.self) { scale in
                Ellipse()
                    .stroke(Color.gold.opacity(0.18 * scale), lineWidth: 1)
                    .frame(width: 260 * scale, height: 60 * scale)
                    .offset(y: 70)
            }

            // Shadow under the orb
            Ellipse()
                .fill(Color.navy.opacity(0.12))
                .frame(width: 140, height: 30)
                .blur(radius: 8)
                .offset(y: 68)

            // The orb
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color(red: 0.98, green: 0.96, blue: 0.93), Color(red: 0.88, green: 0.85, blue: 0.80)],
                        center: UnitPoint(x: 0.38, y: 0.32),
                        startRadius: 10,
                        endRadius: 110
                    )
                )
                .frame(width: 180, height: 180)
                .shadow(color: Color.navy.opacity(0.08), radius: 20, y: 8)

            // Closed eyes
            HStack(spacing: 28) {
                eyeShape
                eyeShape
            }
            .offset(y: 12)

            // Rosy cheeks
            HStack(spacing: 56) {
                Circle()
                    .fill(Color(red: 0.95, green: 0.75, blue: 0.74).opacity(0.55))
                    .frame(width: 22, height: 14)
                Circle()
                    .fill(Color(red: 0.95, green: 0.75, blue: 0.74).opacity(0.55))
                    .frame(width: 22, height: 14)
            }
            .offset(y: 24)
        }
        .frame(height: 220)
    }

    private var eyeShape: some View {
        Path { p in
            p.move(to: .init(x: 0, y: 4))
            p.addCurve(to: .init(x: 14, y: 4),
                       control1: .init(x: 3, y: 0),
                       control2: .init(x: 11, y: 0))
        }
        .stroke(Color.navy.opacity(0.55), style: StrokeStyle(lineWidth: 1.8, lineCap: .round))
        .frame(width: 14, height: 8)
    }
}

// MARK: - Login view

struct LoginView: View {
    var onLogin: () -> Void

    @State private var email    = ""
    @State private var password = ""
    @State private var showError = false
    @State private var isLoading = false

    private let validEmail    = "user@example.com"
    private let validPassword = "password"

    var body: some View {
        ZStack {
            Color.cream.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // ── App name
                    Text("BESTILL")
                        .tracking(4)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.gold)
                        .padding(.top, 56)
                        .padding(.horizontal, 28)

                    // ── Tagline
                    Text("A still mind\nbegins here.")
                        .font(.system(size: 36, weight: .light, design: .serif))
                        .foregroundStyle(Color.navy)
                        .lineSpacing(4)
                        .padding(.top, 12)
                        .padding(.horizontal, 28)

                    // ── Divider
                    Rectangle()
                        .fill(Color.gold.opacity(0.3))
                        .frame(height: 1)
                        .padding(.horizontal, 28)
                        .padding(.top, 24)

                    // ── Lune illustration
                    HStack {
                        Spacer()
                        LuneView()
                        Spacer()
                    }
                    .padding(.top, 24)

                    // ── Hint label
                    HStack {
                        Spacer()
                        VStack(spacing: 2) {
                            Text("SIGN IN TO CONTINUE")
                                .tracking(3)
                                .font(.system(size: 10, weight: .light))
                                .foregroundStyle(Color.gold)
                        }
                        Spacer()
                    }
                    .padding(.top, 8)

                    // ── Fields card
                    VStack(spacing: 24) {
                        UnderlineField(placeholder: "EMAIL", text: $email)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)

                        UnderlineField(placeholder: "PASSWORD", text: $password, isSecure: true)
                            .textContentType(.password)

                        if showError {
                            Text("Incorrect email or password.")
                                .tracking(1)
                                .font(.system(size: 11, weight: .light))
                                .foregroundStyle(Color(red: 0.72, green: 0.30, blue: 0.28))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(28)
                    .background(Color.cardFill)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                    // ── Sign in button
                    Button(action: attemptLogin) {
                        ZStack {
                            if isLoading {
                                ProgressView()
                                    .tint(Color.cream)
                            } else {
                                Text("ENTER")
                                    .tracking(4)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(Color.cream)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(
                            email.isEmpty || password.isEmpty
                                ? Color.gold.opacity(0.4)
                                : Color.gold
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 26))
                    }
                    .disabled(email.isEmpty || password.isEmpty || isLoading)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

                    // ── Footer
                    HStack {
                        Button("Forgot password?") {}
                            .tracking(1)
                            .font(.system(size: 11, weight: .light))
                            .foregroundStyle(Color.muted)

                        Spacer()

                        Button("Create account") {}
                            .tracking(1)
                            .font(.system(size: 11, weight: .light))
                            .foregroundStyle(Color.gold)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    .padding(.bottom, 48)
                }
            }
        }
    }

    private func attemptLogin() {
        showError = false
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            isLoading = false
            if email == validEmail && password == validPassword {
                onLogin()
            } else {
                showError = true
            }
        }
    }
}

#Preview {
    LoginView(onLogin: {})
}
