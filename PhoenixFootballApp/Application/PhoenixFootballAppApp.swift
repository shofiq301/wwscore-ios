//
//  PhoenixFootballAppApp.swift
//  PhoenixFootballApp
//
//  Created by Md Shofiulla on 9/2/25.
//

import EasyX
import EasyXConnect
import SDWebImageSwiftUI
import SwiftUI
import XSwiftUI

import SDWebImageSVGKitPlugin

@main
struct PhoenixFootballAppApp: App {
  @State private var isActive: Bool = false
    @StateObject private var themeManager = ThemeManager.shared
    @StateObject var settingsVIewModel: AppSettingsViewModel = AppSettingsViewModelBindings().getDependency()
    
  var body: some Scene {
    WindowGroup {
      EnvSetupView {
        ZStack(alignment: .center) {
          if isActive {
            ContentView()
            //                        CalendarExample()
          } else {
            SplashScreenView()
          }
        }
      }
//      .onAppear {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//          withAnimation {
//            self.isActive = true
//          }
//        }
//      }
      .task {
          await self.settingsVIewModel.getAppSettings()
          self.isActive = true
      }
      .environmentObject(themeManager)
      .environmentObject(settingsVIewModel)
    }
  }

  init() {
    Initialazer.initSetup()
  }
}

final class Initialazer {
  @MainActor
  static func initSetup() {
    registerBaseUrl()
      registerAdminUrl()
      setUpCacheImage()
  }
  @MainActor
  private static func registerBaseUrl() {
    HTTPClient.enableResponsePrint(label: .notOk)
    HTTPClient.registerBaseUrl(url: "https://api.instacric.live/api/r-f/v3/")
    ApiKeyManager.addSecret(
      key: "x-api-key", value: "d0c[12qzFF?MBSRPQ)556PDfEde8kGOsjc2||@bM:qr[gtPEW256Qew")

  }
    
    private static func setUpCacheImage() {
      SDImageCodersManager.shared.addCoder(SDImageSVGKCoder.shared)
    }
    
    @MainActor
    private static  func registerAdminUrl(){
        let url = URL(string: "https://footy.instacric.live/api/v1/")!
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.httpCookieAcceptPolicy = .never
        configuration.httpShouldSetCookies = false
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
      let session = URLSession(
        configuration: configuration,
        delegate: nil,
        delegateQueue: OperationQueue()
      )
        
        let defaultInterseptor: [Intercepter] = [
         
            AdminClientIntercepter(),
        ]

        let client = ExHttpConnect(baseURL: url,session: session,  intercepters: defaultInterseptor)
        
        DIContainer.shared.register(ExHttpConnect.self,name:DIRegisteredKeys.adminUrl.rawValue, factory: { _ in  client} )
    }

}



final class AdminClientIntercepter: Intercepter {
    func onRequest(req: URLRequest) async throws -> (URLRequest, Data?) {

        var mutableReq = req  // Create a mutable copy of the original URLRequest

        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "x-api-key":"ywef[841?MsfdBSR:|)fef||@bM:qr[d"
        ]

        headers.forEach { key, value in
            // Only set the header if it's not already set
            if mutableReq.value(forHTTPHeaderField: key) == nil {
                mutableReq.setValue(value, forHTTPHeaderField: key)
            }
        }

        return (mutableReq, nil)
    }
    
    func onResponse(req: URLRequest, res: URLResponse?, data: Data,modifiedData: Data?, customResponse: URLResponse?) async throws -> (Data, URLResponse?) {
        return (data, customResponse)
    }
}
