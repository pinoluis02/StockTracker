//
//  SettingsView.swift
//  StockTracker
//
//  Created by Luis Perez on 4/30/25.
//

import SwiftUI

enum ThemeOption: String, CaseIterable, Identifiable {
    case system, light, dark

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .system: return "System Default"
        case .light:  return "Light"
        case .dark:   return "Dark"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light:  return .light
        case .dark:   return .dark
        }
    }
}


struct SettingsView: View {
    @AppStorage("preferredTheme") private var preferredThemeRaw: String = ThemeOption.system.rawValue

    private var preferredTheme: ThemeOption {
        get { ThemeOption(rawValue: preferredThemeRaw) ?? .system }
        set { preferredThemeRaw = newValue.rawValue }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Picker("App Theme", selection: $preferredThemeRaw) {
                    ForEach(ThemeOption.allCases) { theme in
                        Text(theme.displayName).tag(theme.rawValue)
                    }
                }
                .pickerStyle(.inline)
            }
        }
        .navigationTitle("Settings")
    }
}

