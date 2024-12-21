//
//  Daily5EnglishApp.swift
//  Daily5English
//
//  Created by 김민성 on 12/16/24.
//

import SwiftUI

@main
struct Daily5EnglishApp: App {
    
    init () {
        guard let url = Config.supabaseURL else {
            print("url 로드 실패")
            return
        }
        
        guard let api_key = Config.supabaseAPIKey else {
            print("api key 로드 실패")
            return
        }
        
        print(url, api_key)
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
