//
//  WordBookRepository.swift
//  Production
//
//  Created by 김민성 on 12/28/24.
//

import Foundation
import Supabase

final class WordBookRepository {
    private let supabase: SupabaseClient
    private let pageSize: Int = 20
    
    init(supabase: SupabaseClient) {
        self.supabase = supabase
    }
    
    func fetchLearnedWords(userId: String, page: Int) async throws -> [LearnedWord] {
        let from = page * pageSize
        
        let learnedWordDTO: [LearnedWordDTO] = try await supabase
            .from("learned_words")
            .select("""
                word_id,
                reviewed_count,
                learned_at,
                last_reviewed_at,
                words (
                    id,
                    english,
                    korean,
                    part_of_speech,
                    example_sentence,
                    example_sentence_korean,
                    difficulty_level,
                    category
                )
            """)
            .eq("user_id", value: userId)
            .range(from: from, to: from + pageSize - 1)
            .order("learned_at", ascending: false)
            .execute()
            .value
        
        return learnedWordDTO.map { $0.toDomain() }
    }
    
    func fetchCount(userId: String) async throws -> Int {
        let count = try await supabase
          .from("learned_words")
          .select("*", head: true, count: .exact)
          .eq("user_id", value: userId)
          .execute()
          .count
        
        return count ?? 0
    }
}


