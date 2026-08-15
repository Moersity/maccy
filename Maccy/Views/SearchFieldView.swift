import SwiftUI

struct SearchFieldView: View {
  var placeholder: LocalizedStringKey
  @Binding var query: String

  @Environment(AppState.self) private var appState

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 13, style: .continuous)
        .fill(Color.primary.opacity(0.07))
        .overlay {
          RoundedRectangle(cornerRadius: 13, style: .continuous)
            .strokeBorder(Color.primary.opacity(0.08), lineWidth: 0.5)
        }
        .frame(height: Popup.searchFieldHeight)

      HStack(spacing: 12) {
        Image(systemName: "magnifyingglass")
          .font(.system(size: 21, weight: .regular))
          .foregroundStyle(.secondary)
          .frame(width: 24, height: 24)
          .padding(.leading, 15)
          .accessibilityHidden(true)

        TextField(placeholder, text: $query)
          .font(.system(size: 22, weight: .regular))
          .disableAutocorrection(true)
          .lineLimit(1)
          .textFieldStyle(.plain)
          .onSubmit {
            appState.select(flags: .currentModifierFlags)
          }

        if !query.isEmpty {
          Button {
            query = ""
          } label: {
            Image(systemName: "xmark.circle.fill")
              .font(.system(size: 17))
              .foregroundStyle(.secondary)
              .frame(width: 20, height: 20)
              .padding(.trailing, 14)
          }
          .buttonStyle(.plain)
          .opacity(0.9)
          .accessibilityLabel(Text("search_clear_accessibility_label"))
        }
      }
    }
  }
}

#Preview {
  return List {
    SearchFieldView(placeholder: "search_placeholder", query: .constant(""))
    SearchFieldView(placeholder: "search_placeholder", query: .constant("search"))
  }
  .frame(width: 300)
  .environment(\.locale, .init(identifier: "en"))
}
