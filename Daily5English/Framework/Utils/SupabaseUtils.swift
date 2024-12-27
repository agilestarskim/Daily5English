import Foundation
import Supabase

enum SupabaseError: Error {
    case invalidResponse
    case emptyData
    case decodingError(Error)
}

class SupabaseUtils {
    static func decode<T: Codable>(_ response: PostgrestResponse<T>) throws -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: response.data)
        } catch {
            throw SupabaseError.decodingError(error)
        }
    }
    
    static func decodeArray<T: Codable>(_ response: PostgrestResponse<[T]>) throws -> [T] {
        do {
            return try JSONDecoder().decode([T].self, from: response.data)
        } catch {
            throw SupabaseError.decodingError(error)
        }
    }
} 
