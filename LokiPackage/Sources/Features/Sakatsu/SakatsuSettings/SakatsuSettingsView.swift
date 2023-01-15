import SwiftUI
import SakatsuData

struct SakatsuSettingsView: View {
    let defaultSaunaTimes: DefaultSaunaTimes

    let onDefaultSaunaTimeChange: ((TimeInterval?) -> Void)
    let onDefaultCoolBathTimeChange: ((TimeInterval?) -> Void)
    let onDefaultRelaxationTimeChange: ((TimeInterval?) -> Void)

    var body: some View {
        Form {
            defaultSaunaSetsSection
            versionSection
        }
    }

    private var defaultSaunaSetsSection: some View {
        Section {
            defaultTimeInputView(
                emoji: "🔥",
                title: L10n.sauna,
                defaultTime: defaultSaunaTimes.saunaTime,
                unit: L10n.m,
                onTimeChange: onDefaultSaunaTimeChange
            )
            defaultTimeInputView(
                emoji: "💧",
                title: L10n.coolBath,
                defaultTime: defaultSaunaTimes.coolBathTime,
                unit: L10n.s,
                onTimeChange: onDefaultCoolBathTimeChange
            )
            defaultTimeInputView(
                emoji: "🍃",
                title: L10n.relaxation,
                defaultTime: defaultSaunaTimes.relaxationTime,
                unit: L10n.m,
                onTimeChange: onDefaultRelaxationTimeChange
            )
        } header: {
            Text(L10n.defaultTimes)
        }
    }

    private var versionSection: some View {
        Section {
            HStack {
                Text(L10n.version)
                Spacer()
                Text("\(Bundle.main.version) (\(Bundle.main.build))")
            }
        } footer: {
            Text("© 2023 THE Uhooi")
        }
    }

    private func defaultTimeInputView(
        emoji: String,
        title: String,
        defaultTime: TimeInterval?,
        unit: String,
        onTimeChange: @escaping (TimeInterval?) -> Void
    ) -> some View {
        HStack {
            Text(emoji + title)
            TextField(L10n.optional, value: .init(get: {
                defaultTime
            }, set: { newValue in
                onTimeChange(newValue)
            }), format: .number)
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.trailing)
            Text(unit)
        }
    }
}

#if DEBUG
struct SakatsuSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SakatsuSettingsView(
            defaultSaunaTimes: .preview,
            onDefaultSaunaTimeChange: { _ in },
            onDefaultCoolBathTimeChange: { _ in },
            onDefaultRelaxationTimeChange: { _ in }
        )
    }
}
#endif
