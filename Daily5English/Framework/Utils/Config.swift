//
//  Config.swift
//  Daily5English
//
//  Created by 김민성 on 12/21/24.
//

import Foundation

enum Config {
    static let supabaseAPIKey = Bundle.main.infoDictionary?["SUPABASE_API_KEY"] as? String
    static let supabaseURL = Bundle.main.infoDictionary?["SUPABASE_URL"] as? String
}
