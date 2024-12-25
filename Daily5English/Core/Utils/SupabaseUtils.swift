import Foundation

enum SupabaseError: Error {
    case invalidResponse
    case emptyData
    case decodingError(Error)
}

struct SupabaseResponse<T: Codable>: Codable {
    let data: [T]
    let status: Int
    let statusText: String
}

class SupabaseUtils {
    static func decode<T: Codable>(_ data: Data) throws -> T {
        do {
            // 먼저 SupabaseResponse로 디코딩
            let response = try JSONDecoder().decode(SupabaseResponse<T>.self, from: data)
            
            // 상태 코드 확인
            guard response.status == 200 else {
                throw SupabaseError.invalidResponse
            }
            
            // 데이터가 있는지 확인
            guard !response.data.isEmpty else {
                throw SupabaseError.emptyData
            }
            
            // 단일 항목 반환이 필요한 경우 첫 번째 항목 반환
            if let firstItem = response.data.first {
                return firstItem
            }
            
            throw SupabaseError.emptyData
        } catch let error as SupabaseError {
            throw error
        } catch {
            throw SupabaseError.decodingError(error)
        }
    }
    
    static func decodeArray<T: Codable>(_ data: Data) throws -> [T] {
        do {
            let response = try JSONDecoder().decode(SupabaseResponse<T>.self, from: data)
            
            guard response.status == 200 else {
                throw SupabaseError.invalidResponse
            }
            
            return response.data
        } catch let error as SupabaseError {
            throw error
        } catch {
            throw SupabaseError.decodingError(error)
        }
    }
} 