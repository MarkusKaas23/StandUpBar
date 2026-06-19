import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var engine: CycleEngine
    @Binding var showSettings: Bool

    @State private var sitMinutes:   Double = 30
    @State private var standMinutes: Double = 15
    @State private var goalPercent:  Double = 40

    var body: some View {
        VStack(spacing: 0) {

            // Back header
            HStack {
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) { showSettings = false }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 11, weight: .semibold))
                        Text("Back")
                            .font(.system(size: 13))
                    }
                    .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)

                Spacer()

                Text("Settings")
                    .font(.system(size: 13, weight: .semibold))

                Spacer()

                // Balance the back button
                Color.clear.frame(width: 48, height: 1)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)

            Divider()

            ScrollView {
                VStack(spacing: 18) {

                    // ── Presets ───────────────────────────────────────────
                    VStack(alignment: .leading, spacing: 8) {
                        sectionLabel("Quick presets")
                        HStack(spacing: 8) {
                            PresetButton(title: "Starter",
                                         subtitle: "50/10 min",
                                         sit: 50, stand: 10) { applyPreset($0, $1) }
                            PresetButton(title: "Standard",
                                         subtitle: "30/15 min",
                                         sit: 30, stand: 15) { applyPreset($0, $1) }
                            PresetButton(title: "Advanced",
                                         subtitle: "20/15 min",
                                         sit: 20, stand: 15) { applyPreset($0, $1) }
                        }
                    }

                    // ── Sit duration ──────────────────────────────────────
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Label("Sitting duration", systemImage: "figure.seated.side")
                                .font(.system(size: 13))
                            Spacer()
                            Text("\(Int(sitMinutes)) min")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.indigo)
                        }
                        Slider(value: $sitMinutes, in: 10...60, step: 5)
                            .tint(.indigo)
                    }

                    // ── Stand duration ────────────────────────────────────
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Label("Standing duration", systemImage: "figure.stand")
                                .font(.system(size: 13))
                            Spacer()
                            Text("\(Int(standMinutes)) min")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.green)
                        }
                        Slider(value: $standMinutes, in: 5...30, step: 5)
                            .tint(.green)
                    }

                    // ── Weekly goal ───────────────────────────────────────
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Label("Weekly standing goal", systemImage: "target")
                                .font(.system(size: 13))
                            Spacer()
                            Text("\(Int(goalPercent))%")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.orange)
                        }
                        Slider(value: $goalPercent, in: 20...65, step: 5)
                            .tint(.orange)
                        Text("WHO recommends 30–40% of work time standing.")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }

                    Divider()

                    // ── Launch at Login ───────────────────────────────────
                    Toggle(isOn: Binding(
                        get: { engine.settings.launchAtLogin },
                        set: { engine.setLaunchAtLogin($0) }
                    )) {
                        Label("Launch at Login", systemImage: "power")
                            .font(.system(size: 13))
                    }
                    .toggleStyle(.switch)

                    Divider()

                    // ── Save ──────────────────────────────────────────────
                    Button {
                        engine.applySettings(AppSettings(
                            sitMinutes:    Int(sitMinutes),
                            standMinutes:  Int(standMinutes),
                            goalPercent:   Int(goalPercent),
                            launchAtLogin: engine.settings.launchAtLogin
                        ))
                        withAnimation(.easeInOut(duration: 0.2)) { showSettings = false }
                    } label: {
                        Text("Save")
                            .font(.system(size: 14, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color.indigo)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)

                    // ── Danger zone ───────────────────────────────────────
                    Button {
                        engine.sessions = []
                        Session.saveAll([])
                    } label: {
                        Text("Clear all data")
                            .font(.system(size: 12))
                            .foregroundColor(.red.opacity(0.7))
                    }
                    .buttonStyle(.plain)
                }
                .padding(16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.regularMaterial)
        .onAppear {
            sitMinutes   = Double(engine.settings.sitMinutes)
            standMinutes = Double(engine.settings.standMinutes)
            goalPercent  = Double(engine.settings.goalPercent)
        }
    }

    private func applyPreset(_ sit: Double, _ stand: Double) {
        withAnimation { sitMinutes = sit; standMinutes = stand }
    }

    private func sectionLabel(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 11, weight: .medium))
            .foregroundColor(.secondary)
            .textCase(.uppercase)
            .tracking(1.5)
    }
}

// MARK: - Preset Button
private struct PresetButton: View {
    let title:    String
    let subtitle: String
    let sit:      Double
    let stand:    Double
    let onTap:    (Double, Double) -> Void

    var body: some View {
        Button { onTap(sit, stand) } label: {
            VStack(spacing: 2) {
                Text(title)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 7)
            .background(Color(nsColor: .controlBackgroundColor))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(nsColor: .separatorColor), lineWidth: 0.5)
            )
        }
        .buttonStyle(.plain)
    }
}
