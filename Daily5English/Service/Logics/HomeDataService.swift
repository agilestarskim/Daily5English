//
//  HomeDataService.swift
//  Daily5English
//
//  Created by 김민성 on 1/7/25.
//

import Foundation
import SwiftUI

@Observable
final class HomeDataService {
    var stat: LearningStatistics = .defaults
    var tip: LearningTip = .defaults
    
    private var userId: String? = nil
    private var tips: [LearningTip] = []
    private let repository: HomeDataRepository
    
    init(repository: HomeDataRepository) {
        self.repository = repository
    }
    
    //로그인 성공시 꼭 호출해야함.
    func setUserId(_ userId: String) {
        self.userId = userId
    }
    
    @MainActor
    func fetchTips() async {
        do {
            self.tips = try await repository.fetchLearningTips()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func refreshTip() {
        self.tip = tips.randomElement() ?? .defaults
    }
    
    @MainActor
    func fetchStatistics() async {
        guard let userId else { return }
        
        do {        
            self.stat = try await repository.fetchLearningStatistics(userId: userId)
            print("fetched")
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveStatistics(wordsCount: Int) async {
        guard let userId else { return }
        
        do {
            try await repository.updateLearningStatistics(
                userId: userId,
                wordsCount: wordsCount
            )
            
        } catch {
            print("Fail to save statistics: \(error.localizedDescription)")
        }
    }

}
