import Combine
import SwiftUI

// MARK: - Shade Constants
enum ShadeDepth: Int, CaseIterable {
  case sd50 = 50
  case sd100 = 100
  case sd200 = 200
  case sd300 = 300
  case sd400 = 400
  case sd500 = 500
  case sd600 = 600
  case sd700 = 700
  case sd800 = 800
  case sd900 = 900

  var value: Int {
    return self.rawValue
  }
}

// MARK: - Shade Access Helpers
@dynamicMemberLookup
struct ColorShadeGroup: Equatable {
  private let colors: [Int: Color]
  private let defaultColor: Color

  init(colors: [Int: Color], defaultColor: Color) {
    self.colors = colors
    self.defaultColor = defaultColor
  }

  subscript(dynamicMember name: String) -> Color {
    // Check if it's one of our predefined shade constants (sd100, sd200, etc.)
    if name.hasPrefix("sd"), let rest = Int(name.dropFirst(2)) {
      return colors[rest] ?? defaultColor
    }
    return defaultColor
  }

  // Allow direct access through ShadeDepth enum
  subscript(shade: ShadeDepth) -> Color {
    return colors[shade.value] ?? defaultColor
  }

  // Allow direct integer subscript access as well (for backward compatibility)
  subscript(shade: Int) -> Color {
    return colors[shade] ?? defaultColor
  }

  // MARK: - Equatable Conformance
  static func == (lhs: ColorShadeGroup, rhs: ColorShadeGroup) -> Bool {
    // This is a simplified implementation that compares the dictionaries
    // A more thorough implementation would compare each color in the dictionary
    return lhs.colors == rhs.colors && lhs.defaultColor == rhs.defaultColor
  }
}

// MARK: - Color Theme Model
struct ColorTheme: Equatable, Identifiable {
  let id: String
  let name: String

  // Base colors
  private let primaryColors: [Int: Color]
  private let secondaryColors: [Int: Color]
  private let textColors: [Int: Color]
  private let redColors: [Int: Color]
  private let greenColors: [Int: Color]
  private let backgroundColors: [Int: Color]

  // Shade groups with dynamic member lookup
  var primary: ColorShadeGroup
  var secondary: ColorShadeGroup
  var text: ColorShadeGroup
  var red: ColorShadeGroup
  var green: ColorShadeGroup
  var background: ColorShadeGroup

  init(
    id: String,
    name: String,
    primary: [Int: Color],
    secondary: [Int: Color],
    text: [Int: Color],
    red: [Int: Color],
    green: [Int: Color],
    background: [Int: Color]
  ) {
    self.id = id
    self.name = name

    self.primaryColors = primary
    self.secondaryColors = secondary
    self.textColors = text
    self.redColors = red
    self.greenColors = green
    self.backgroundColors = background

    let defaultPrimary = primary[500] ?? .blue
    let defaultSecondary = secondary[500] ?? .cyan
    let defaultText = text[500] ?? .black
    let defaultRed = red[500] ?? .red
    let defaultGreen = green[500] ?? .green
    let defaultBackground = background[500] ?? .gray

    self.primary = ColorShadeGroup(colors: primary, defaultColor: defaultPrimary)
    self.secondary = ColorShadeGroup(colors: secondary, defaultColor: defaultSecondary)
    self.text = ColorShadeGroup(colors: text, defaultColor: defaultText)
    self.red = ColorShadeGroup(colors: red, defaultColor: defaultRed)
    self.green = ColorShadeGroup(colors: green, defaultColor: defaultGreen)
    self.background = ColorShadeGroup(colors: background, defaultColor: defaultBackground)
  }

  // For backward compatibility
  var primaryDefault: Color { primaryColors[500] ?? .blue }
  var secondaryDefault: Color { secondaryColors[500] ?? .cyan }
  var textDefault: Color { textColors[500] ?? .black }
  var redDefault: Color { redColors[500] ?? .red }
  var greenDefault: Color { greenColors[500] ?? .green }
  var backgroundDefault: Color { backgroundColors[900] ?? .gray }

  // Helper functions for backward compatibility
  func primaryShade(_ shade: Int) -> Color { primaryColors[shade] ?? primaryDefault }
  func secondaryShade(_ shade: Int) -> Color { secondaryColors[shade] ?? secondaryDefault }
  func textShade(_ shade: Int) -> Color { textColors[shade] ?? textDefault }
  func redShade(_ shade: Int) -> Color { redColors[shade] ?? redDefault }
  func greenShade(_ shade: Int) -> Color { greenColors[shade] ?? greenDefault }
  func backgroundShade(_ shade: Int) -> Color { backgroundColors[shade] ?? backgroundDefault }

  // MARK: - Equatable Conformance
  static func == (lhs: ColorTheme, rhs: ColorTheme) -> Bool {
    // Compare by ID for efficiency
    // Two themes with the same ID are considered equal
    return lhs.id == rhs.id
  }
}

// MARK: - Theme Manager
class ThemeManager: ObservableObject {
    @Published private(set) var currentTheme: ColorTheme
    private(set) var availableThemes: [ColorTheme]
    
    // UserDefaults keys
    private enum UserDefaultsKeys {
        static let selectedThemeId = "com.app.selectedThemeId"
    }
    
    // Singleton instance
    static let shared = ThemeManager()
    
    // Private initializer for singleton
    private init() {
        // Initialize available themes
        self.availableThemes = [
            .defaultTheme
            // Add more themes here if needed
        ]
        
        // Try to load the previously selected theme from UserDefaults
        if let savedThemeId = UserDefaults.standard.string(forKey: UserDefaultsKeys.selectedThemeId),
           let savedTheme = availableThemes.first(where: { $0.id == savedThemeId }) {
            self.currentTheme = savedTheme
        } else {
            // Use default theme if no saved theme exists
            self.currentTheme = availableThemes.first!
            
            // Save default theme ID to UserDefaults
            saveSelectedTheme(id: currentTheme.id)
        }
    }
    
    // Set theme by ID and save to UserDefaults
    func setTheme(id: String) {
        if let theme = availableThemes.first(where: { $0.id == id }) {
            // Only update and save if the theme is actually changing
            if currentTheme.id != theme.id {
                currentTheme = theme
                saveSelectedTheme(id: id)
            }
        }
    }
    
    // Save the selected theme ID to UserDefaults
    private func saveSelectedTheme(id: String) {
        UserDefaults.standard.set(id, forKey: UserDefaultsKeys.selectedThemeId)
    }
    
    // Add a new theme
    func addTheme(_ theme: ColorTheme) {
        if !availableThemes.contains(where: { $0.id == theme.id }) {
            availableThemes.append(theme)
        }
    }
    
    // Get a theme by ID
    func getTheme(id: String) -> ColorTheme? {
        return availableThemes.first(where: { $0.id == id })
    }
    
    // Reset to default theme
    func resetToDefaultTheme() {
        if let defaultTheme = availableThemes.first {
            currentTheme = defaultTheme
            saveSelectedTheme(id: defaultTheme.id)
        }
    }
    
}
extension ColorTheme {
  static let defaultTheme = ColorTheme(
    id: "default",
    name: "Default",
    primary: [
      ShadeDepth.sd50.value: Color(hex: "E8F1FB"),  // rgb(232, 241, 251)
      ShadeDepth.sd100.value: Color(hex: "B8D5F1"),  // rgb(184, 213, 241)
      ShadeDepth.sd200.value: Color(hex: "95C0EA"),  // rgb(149, 192, 234)
      ShadeDepth.sd300.value: Color(hex: "65A3E1"),  // rgb(101, 163, 225)
      ShadeDepth.sd400.value: Color(hex: "4791DB"),  // rgb(71, 145, 219)
      ShadeDepth.sd500.value: Color(hex: "1976D2"),  // rgb(25, 118, 210)
      ShadeDepth.sd600.value: Color(hex: "176BBF"),  // rgb(23, 107, 191)
      ShadeDepth.sd700.value: Color(hex: "125495"),  // rgb(18, 84, 149)
      ShadeDepth.sd800.value: Color(hex: "0E4174"),  // rgb(14, 65, 116)
      ShadeDepth.sd900.value: Color(hex: "0B3258"),  // rgb(11, 50, 88)
    ],
    secondary: [
      ShadeDepth.sd50.value: Color(hex: "F3FAFD"),  // rgb(243, 250, 253)
      ShadeDepth.sd100.value: Color(hex: "DAF0F9"),  // rgb(218, 240, 249)
      ShadeDepth.sd200.value: Color(hex: "C8E8F6"),  // rgb(200, 232, 246)
      ShadeDepth.sd300.value: Color(hex: "AFDEF2"),  // rgb(175, 222, 242)
      ShadeDepth.sd400.value: Color(hex: "9FD8EF"),  // rgb(159, 216, 239)
      ShadeDepth.sd500.value: Color(hex: "87CEEB"),  // rgb(135, 206, 235)
      ShadeDepth.sd600.value: Color(hex: "7BBBD6"),  // rgb(123, 187, 214)
      ShadeDepth.sd700.value: Color(hex: "6092A7"),  // rgb(96, 146, 167)
      ShadeDepth.sd800.value: Color(hex: "4A7181"),  // rgb(74, 113, 129)
      ShadeDepth.sd900.value: Color(hex: "395763"),  // rgb(57, 87, 99)
    ],
    text: [
      ShadeDepth.sd50.value: Color(hex: "F7F7F8"),  // rgb(247, 247, 248)
      ShadeDepth.sd100.value: Color(hex: "E7E7EA"),  // rgb(231, 231, 234)
      ShadeDepth.sd200.value: Color(hex: "DCDBDF"),  // rgb(220, 219, 223)
      ShadeDepth.sd300.value: Color(hex: "CCCBD1"),  // rgb(204, 203, 209)
      ShadeDepth.sd400.value: Color(hex: "C2C1C8"),  // rgb(194, 193, 200)
      ShadeDepth.sd500.value: Color(hex: "B3B1BA"),  // rgb(179, 177, 186)
      ShadeDepth.sd600.value: Color(hex: "A3A1A9"),  // rgb(163, 161, 169)
      ShadeDepth.sd700.value: Color(hex: "7F7E84"),  // rgb(127, 126, 132)
      ShadeDepth.sd800.value: Color(hex: "626166"),  // rgb(98, 97, 102)
      ShadeDepth.sd900.value: Color(hex: "4B4A4E"),  // rgb(75, 74, 78)
    ],
    red: [
      ShadeDepth.sd50.value: Color(hex: "FDECEC"),  // rgb(253, 236, 236)
      ShadeDepth.sd100.value: Color(hex: "FAC5C5"),  // rgb(250, 197, 197)
      ShadeDepth.sd200.value: Color(hex: "F8A9A9"),  // rgb(248, 169, 169)
      ShadeDepth.sd300.value: Color(hex: "F48282"),  // rgb(244, 130, 130)
      ShadeDepth.sd400.value: Color(hex: "F26969"),  // rgb(242, 105, 105)
      ShadeDepth.sd500.value: Color(hex: "EF4444"),  // rgb(239, 68, 68)
      ShadeDepth.sd600.value: Color(hex: "D93E3E"),  // rgb(217, 62, 62)
      ShadeDepth.sd700.value: Color(hex: "AA3030"),  // rgb(170, 48, 48)
      ShadeDepth.sd800.value: Color(hex: "832525"),  // rgb(131, 37, 37)
      ShadeDepth.sd900.value: Color(hex: "641D1D"),  // rgb(100, 29, 29)
    ],
    green: [
      ShadeDepth.sd50.value: Color(hex: "E9F9EF"),  // rgb(233, 249, 239)
      ShadeDepth.sd100.value: Color(hex: "BAEDCD"),  // rgb(186, 237, 205)
      ShadeDepth.sd200.value: Color(hex: "99E4B5"),  // rgb(153, 228, 181)
      ShadeDepth.sd300.value: Color(hex: "6BD893"),  // rgb(107, 216, 147)
      ShadeDepth.sd400.value: Color(hex: "4ED17E"),  // rgb(78, 209, 126)
      ShadeDepth.sd500.value: Color(hex: "22C55E"),  // rgb(34, 197, 94)
      ShadeDepth.sd600.value: Color(hex: "1FB356"),  // rgb(31, 179, 86)
      ShadeDepth.sd700.value: Color(hex: "188C43"),  // rgb(24, 140, 67)
      ShadeDepth.sd800.value: Color(hex: "136C34"),  // rgb(19, 108, 52)
      ShadeDepth.sd900.value: Color(hex: "0E5327"),  // rgb(14, 83, 39)
    ],
    background: [
      ShadeDepth.sd50.value: Color(hex: "E6E6E7"),  // rgb(230, 230, 231)
      ShadeDepth.sd100.value: Color(hex: "B0B2B4"),  // rgb(176, 178, 180)
      ShadeDepth.sd200.value: Color(hex: "8A8D90"),  // rgb(138, 141, 144)
      ShadeDepth.sd300.value: Color(hex: "555A5E"),  // rgb(85, 90, 94)
      ShadeDepth.sd400.value: Color(hex: "34393E"),  // rgb(52, 57, 62)
      ShadeDepth.sd500.value: Color(hex: "01080E"),  // rgb(1, 8, 14)
      ShadeDepth.sd600.value: Color(hex: "01070D"),  // rgb(1, 7, 13)
      ShadeDepth.sd700.value: Color(hex: "01060A"),  // rgb(1, 6, 10)
      ShadeDepth.sd800.value: Color(hex: "010408"),  // rgb(1, 4, 8)
      ShadeDepth.sd900.value: Color(hex: "000306"),  // rgb(0, 3, 6)
    ]
  )
}
