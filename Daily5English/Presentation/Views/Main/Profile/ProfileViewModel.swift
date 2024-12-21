//
//  ProfileViewModel.swift
//  Production
//
//  Created by 김민성 on 12/22/24.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var userName = "사용자"
    @Published var userEmail = "user@example.com"
    
    @Published var learnedWords = 150
    @Published var streakDays = 7
    @Published var totalLearningDays = 14
    
    @Published var learningLevel: LearningLevel = .beginner
    @Published var category: LearningCategory = .daily
    @Published var dailyGoal = 5
    
    @Published var isNotificationEnabled = true
    @Published var learningStartTime = Date()
    @Published var reviewStartTime = Date()
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
}
