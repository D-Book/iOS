//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try font.validate()
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 7 storyboards.
  struct storyboard {
    /// Storyboard `BookDetail`.
    static let bookDetail = _R.storyboard.bookDetail()
    /// Storyboard `BookList`.
    static let bookList = _R.storyboard.bookList()
    /// Storyboard `CreateProfile`.
    static let createProfile = _R.storyboard.createProfile()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `MyLibrary`.
    static let myLibrary = _R.storyboard.myLibrary()
    /// Storyboard `SignIn`.
    static let signIn = _R.storyboard.signIn()
    /// Storyboard `SignUp`.
    static let signUp = _R.storyboard.signUp()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "BookDetail", bundle: ...)`
    static func bookDetail(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.bookDetail)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "BookList", bundle: ...)`
    static func bookList(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.bookList)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "CreateProfile", bundle: ...)`
    static func createProfile(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.createProfile)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "MyLibrary", bundle: ...)`
    static func myLibrary(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.myLibrary)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "SignIn", bundle: ...)`
    static func signIn(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.signIn)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "SignUp", bundle: ...)`
    static func signUp(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.signUp)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `JalnanOTF.otf`.
    static let jalnanOTFOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "JalnanOTF", pathExtension: "otf")

    /// `bundle.url(forResource: "JalnanOTF", withExtension: "otf")`
    static func jalnanOTFOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.jalnanOTFOtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.font` struct is generated, and contains static references to 1 fonts.
  struct font: Rswift.Validatable {
    /// Font `JalnanOTF`.
    static let jalnanOTF = Rswift.FontResource(fontName: "JalnanOTF")

    /// `UIFont(name: "JalnanOTF", size: ...)`
    static func jalnanOTF(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: jalnanOTF, size: size)
    }

    static func validate() throws {
      if R.font.jalnanOTF(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'JalnanOTF' could not be loaded, is 'JalnanOTF.otf' added to the UIAppFonts array in this targets Info.plist?") }
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 10 images.
  struct image {
    /// Image `BarBT_Setting`.
    static let barBT_Setting = Rswift.ImageResource(bundle: R.hostingBundle, name: "BarBT_Setting")
    /// Image `BookListIcon`.
    static let bookListIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "BookListIcon")
    /// Image `Fail`.
    static let fail = Rswift.ImageResource(bundle: R.hostingBundle, name: "Fail")
    /// Image `LeftArrow`.
    static let leftArrow = Rswift.ImageResource(bundle: R.hostingBundle, name: "LeftArrow")
    /// Image `Logo`.
    static let logo = Rswift.ImageResource(bundle: R.hostingBundle, name: "Logo")
    /// Image `MyLibraryIcon`.
    static let myLibraryIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "MyLibraryIcon")
    /// Image `RoundBT_Disable`.
    static let roundBT_Disable = Rswift.ImageResource(bundle: R.hostingBundle, name: "RoundBT_Disable")
    /// Image `RoundBT`.
    static let roundBT = Rswift.ImageResource(bundle: R.hostingBundle, name: "RoundBT")
    /// Image `Success`.
    static let success = Rswift.ImageResource(bundle: R.hostingBundle, name: "Success")
    /// Image `TextField`.
    static let textField = Rswift.ImageResource(bundle: R.hostingBundle, name: "TextField")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "BarBT_Setting", bundle: ..., traitCollection: ...)`
    static func barBT_Setting(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.barBT_Setting, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "BookListIcon", bundle: ..., traitCollection: ...)`
    static func bookListIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.bookListIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Fail", bundle: ..., traitCollection: ...)`
    static func fail(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.fail, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "LeftArrow", bundle: ..., traitCollection: ...)`
    static func leftArrow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.leftArrow, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Logo", bundle: ..., traitCollection: ...)`
    static func logo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.logo, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "MyLibraryIcon", bundle: ..., traitCollection: ...)`
    static func myLibraryIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.myLibraryIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "RoundBT", bundle: ..., traitCollection: ...)`
    static func roundBT(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.roundBT, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "RoundBT_Disable", bundle: ..., traitCollection: ...)`
    static func roundBT_Disable(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.roundBT_Disable, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Success", bundle: ..., traitCollection: ...)`
    static func success(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.success, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "TextField", bundle: ..., traitCollection: ...)`
    static func textField(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.textField, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try bookDetail.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try bookList.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try createProfile.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try myLibrary.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try signIn.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try signUp.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct bookDetail: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "BookDetail"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct bookList: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "BookList"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct createProfile: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "CreateProfile"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct myLibrary: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "MyLibrary"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct signIn: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "SignIn"
      let signInViewController = StoryboardViewControllerResource<SignInViewController>(identifier: "SignInViewController")

      func signInViewController(_: Void = ()) -> SignInViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: signInViewController)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "Logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Logo' is used in storyboard 'SignIn', but couldn't be loaded.") }
        if UIKit.UIImage(named: "RoundBT", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'RoundBT' is used in storyboard 'SignIn', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.signIn().signInViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'signInViewController' could not be loaded from storyboard 'SignIn' as 'SignInViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct signUp: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "SignUp"

      static func validate() throws {
        if UIKit.UIImage(named: "Logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Logo' is used in storyboard 'SignUp', but couldn't be loaded.") }
        if UIKit.UIImage(named: "RoundBT", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'RoundBT' is used in storyboard 'SignUp', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
