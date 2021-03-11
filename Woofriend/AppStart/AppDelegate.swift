//
//  AppDelegate.swift
//  woofriend
//
//  Created by 이규현 on 2021/01/25.
//

import UIKit
import CoreData
import Firebase
import RIBs
import NaverThirdPartyLogin
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var launchRouter: LaunchRouting?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        self.window?.overrideUserInterfaceStyle = .light
        
        // SNS 로그인
        naverLogin()
        kakaoLogin()
        
        FirebaseApp.configure()
        
        /*
         AppComponent가 주입된 Root RIB을 생성하고
         Router tree의 시작점 Root RIB으로 설정하고
         메인 window 객체 위에 라우터 트리를 시작한다.
         */
        let launchRouter = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = launchRouter
        launchRouter.launchFromWindow(window)
        
        return true
    }
    
    // URL를 열때
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        //
        NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
        // 네이버 로그인 스킴
        if url.absoluteString.hasPrefix("naverlogin://") {
            let scanner = Scanner(string: url.absoluteString)
            /* 수신 스킴 예시
             naverlogin://thirdPartyLoginResult?version=2&code=0&authCode=TlHFy1sI8Pxz93MlLk
             
             */
        }
        
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        }
        
        return true
    }
    
    private func naverLogin() {
        let naverLogionInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        // 네이버 앱으로 인증
        naverLogionInstance?.isInAppOauthEnable = true
        // 웹으로 인증
        naverLogionInstance?.isNaverAppOauthEnable = true
        // 세로모드만
        naverLogionInstance?.setOnlyPortraitSupportInIphone(true)
        
        // developers.naver.com 내 앱 설정
        naverLogionInstance?.serviceUrlScheme = "naverlogin"
        naverLogionInstance?.consumerKey = "bcAnKOWT51cvDGNrhulw"
        naverLogionInstance?.consumerSecret = "WrMY7L0_yh"
        naverLogionInstance?.appName = "같이가개"
    }
    
    private func kakaoLogin() {
        KakaoSDKCommon.initSDK(appKey: "a05e3ce686fef3f616ff4d92d857f5fb")
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "woofriend")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
