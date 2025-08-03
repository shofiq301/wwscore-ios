//
//  AppTextField.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 3/18/25.
//

import SwiftUI
import PhoenixUI
import XSwiftUI

public protocol TextInputFormatter {
  func format(_ text: String) -> String
}

public struct TextOnlyInputFormatter: TextInputFormatter {

  public init() {}

  public func format(_ text: String) -> String {
    // Filter out any non-alphabetic characters
    return text.filter { $0.isLetter }
  }
}

public struct TextLowerCaseInputFormatter: TextInputFormatter {
    
    public init() {}
    
    public func format(_ text: String) -> String {
        // Filter out non-alphabetic characters and convert to lowercase
        return text.lowercased()
    }
}

public struct NumberOnlyInputFormatter: TextInputFormatter {

  public init() {}

  public func format(_ text: String) -> String {
    // Filter out any non-numeric characters
    return text.filter { $0.isNumber }
  }
}

public struct ContentPadding{
   let edges: Edge.Set
   let length: CGFloat?
    
    public init(edges: Edge.Set = .all , length: CGFloat? = nil) {
        self.edges = edges
        self.length = length
    }
    
    
}

public struct AppTextField<Prefix: View, Suffix: View>: View {
  @Binding private var text: String
  private var textColor: Color
  private var activeBorderColor: Color
  private var inactiveBorderColor: Color
  private var backGroundColor: Color
  private var textFieldTitle: String?
  private var placeholderText: String
  private var textFieldDisabled: Bool
  private var secured: Bool
  private var prefixView: Prefix?
  private var suffixView: Suffix?
  private var onTapAction: (() -> Void)?
  private var onValidate: ((String) -> String?)?
  @State private var isValid: Bool = true
  private var errorColor: Color
  private var showErrorText: Bool

  private var keyboardType: UIKeyboardType
  private var isAutocorrectionDisabled: Bool
  private var textFieldId: String?
  private var inputFormatters: [TextInputFormatter]
  private var contentPadding: ContentPadding
    
  @FocusState private var isFocused: Bool
  @State private var hasInteracted: Bool = false
  @State private var errorText: String? = nil
  public init(
    textfieldTitle: String? = nil,
    placeholderText: String,
    textFieldDisabled: Bool = false,
    text: Binding<String>,
    textColor: Color = .white,//Color(hex: "A3A1A9"),
    secured: Bool = false,
    backGroundColor: Color = Color(hex:"01080E"),
    activeBorderColor: Color = .blue,
    inactiveBorderColor: Color = Color(UIColor.systemGray4),
    errorColor: Color = .red,
    inputFormatters: [TextInputFormatter] = [],
    @ViewBuilder prefixView: () -> Prefix,
    @ViewBuilder suffixView: () -> Suffix,
    onTapAction: (() -> Void)? = nil,
    onValidate: ((String) -> String?)? = nil,
    keyboardType: UIKeyboardType = .default,
    isAutocorrectionDisabled: Bool = true,
    showErrorText: Bool = false,
    textFieldId: String? = nil,
    contentPadding: ContentPadding = ContentPadding(edges: .all,length: 16)

  ) {
    self.textFieldTitle = textfieldTitle
    self.placeholderText = placeholderText
    self.textFieldDisabled = textFieldDisabled
    self.prefixView = prefixView()
    self.suffixView = suffixView()
    self.onTapAction = onTapAction
    self._text = text
    self.activeBorderColor = activeBorderColor
    self.inactiveBorderColor = inactiveBorderColor
    self.backGroundColor = backGroundColor
    self.textColor = textColor
    self.errorColor = errorColor
    self.onValidate = onValidate
    self.keyboardType = keyboardType
    self.isAutocorrectionDisabled = isAutocorrectionDisabled
    self.textFieldId = textFieldId
    self.secured = secured
    self.inputFormatters = inputFormatters
    self.showErrorText = showErrorText
    self.contentPadding = contentPadding

    // Perform initial validation
    if let validate = onValidate {
      let error = validate(self.text)
      self._isValid = State(initialValue: error == nil)
    }
  }

  public var body: some View {
    VStack(spacing: 8) {
      if let textFieldTitle = textFieldTitle {
        Text(textFieldTitle)
              .font(.manrope(.medium, size: 14.height()))
              .foregroundColor(Color(hex: "34393E"))
          .frame(maxWidth: .infinity, idealHeight: 16, alignment: .leading)
      }

      HStack(spacing: 8) {
        prefixView

        textField
          .onChange(of: text) { newValue in
            hasInteracted = true
            var tempText = newValue
            for formatter in inputFormatters {
              tempText = formatter.format(text)
            }
            text = tempText
            validateText(tempText)
          }
          .disabled(textFieldDisabled)
//          .foregroundColor(textColor)
          
          
          .focused($isFocused)
         
          
          

        suffixView
      }
//      .padding(16)
      .padding(contentPadding.edges, contentPadding.length)
      .background(
        RoundedRectangle(cornerRadius: 10)
          .stroke(borderColor, lineWidth: 1)
      )
      .background(
        RoundedRectangle(cornerRadius: 10)
          .fill(backGroundColor)
      )
      .onTapGesture {
        if !isFocused {
          isFocused = true
        }
        self.onTapAction?()
      }

      if isValid == false && errorText != nil && showErrorText == true {
        Text(errorText ?? "")
              .font(.manrope(.regular, size: 12.height()))
          .foregroundColor(Color.red)
          .frame(maxWidth: .infinity, idealHeight: 16, alignment: .leading)
      }

    }
  }

  private var borderColor: Color {
    if hasInteracted && !isValid {
      return errorColor
    } else if isFocused {
      return activeBorderColor
    } else {
      return inactiveBorderColor
    }
  }

  private var textField: some View {
    Group {
      if secured {
        SecureField(placeholderText, text: $text)

          .font(.system(size: 14, weight: .regular))
          .foregroundStyle(textColor)
          .keyboardType(keyboardType)
          .autocorrectionDisabled(isAutocorrectionDisabled)
          .submitLabel(.done)
          .id(textFieldId)
          .placeholder(when: text.isEmpty) {
                  Text(placeholderText)
                  .font(.system(size: 14, weight: .regular))
                  .foregroundColor(.gray) // This sets placeholder text color
              }
      } else {
        TextField("", text: $text)
          .font(.system(size: 14, weight: .regular))
          .foregroundStyle(textColor)
          .keyboardType(keyboardType)
          .autocorrectionDisabled(isAutocorrectionDisabled)
          .submitLabel(.done)
          .id(textFieldId)
          .textInputAutocapitalization(.never)
          .placeholder(when: text.isEmpty) {
                  Text(placeholderText)
                  .font(.system(size: 14, weight: .regular))
                  .foregroundColor(.gray) // This sets placeholder text color
              }
         
          
      }
    }
  }

  private func validateText(_ value: String) {

    if let onValidate = onValidate {
      //      isValid
      if let error = onValidate(value) {
        isValid = false
        errorText = error
      } else {
        isValid = true
        errorText = nil
      }
    }
  }

  // MARK: - Modifier functions

  public func autocorrectionDisabled(_ disabled: Bool) -> AppTextField {
    var view = self
    view.isAutocorrectionDisabled = disabled
    return view
  }

  public func keyboardType(_ type: UIKeyboardType) -> AppTextField {
    var view = self
    view.keyboardType = type
    return view
  }

  public func id(_ id: String) -> AppTextField {
    var view = self
    view.textFieldId = id
    return view
  }

  public func setBackgroundColor(_ color: Color) -> AppTextField {
    var view = self
    view.backGroundColor = color
    return view
  }
}
// MARK: - Preview

struct AppTextFieldPreview: View {
  @State var text: String = ""
  @State var text2: String = ""
  @State var text3: String = ""

  var body: some View {
    VStack(spacing: 20) {
      AppTextField(
        textfieldTitle: "Username",
        placeholderText: "Enter your username",
        text: $text,
        inputFormatters: [
          TextOnlyInputFormatter()
        ],
        prefixView: { EmptyView() },
        suffixView: { EmptyView() },

        onValidate: { text in
          print(text)
          return text.count >= 3 ? nil : "user name too short"
        },
        textFieldId: "masud"
      )

      AppTextField(
        textfieldTitle: "Email",
        placeholderText: "Enter your email",

        text: $text2,
        prefixView: {
          Text("@")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.blue)
        },
        suffixView: {},
        onValidate: { text in
          return text.contains("@") && text.contains(".") ? nil : "email is not valid"
        }
      )
      .keyboardType(.emailAddress)

      AppTextField(
        textfieldTitle: "Password",
        placeholderText: "Enter your password",
        text: $text3,
        secured: false,
        activeBorderColor: .green,
        inactiveBorderColor: .yellow,
        inputFormatters: [
          NumberOnlyInputFormatter()
        ],
        prefixView: {

        },
        suffixView: {
          Text("Show")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.green)
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            .background(
              RoundedRectangle(cornerRadius: 6)
                .fill(Color(UIColor.systemGray5))
            )
        },
        onValidate: { text in
          return text.count >= 8 ? nil : "password is not valid"
        }
      )
      .keyboardType(.default)
    }
    .padding()
  }
}

struct AppTextField2_Previews: PreviewProvider {
  static var previews: some View {
    AppTextFieldPreview()
  }
}
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
