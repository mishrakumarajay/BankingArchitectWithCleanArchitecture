//
//  LiveNetworkManager.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 22/07/2026.
//


import Foundation
import Combine

// 1. We must conform to URLSessionDelegate to handle the SSL Pinning challenge
public final class LiveNetworkManager: NSObject, URLSessionDelegate {
    
    private var session: URLSession!
    
    public override init() {
        super.init()
        
        // 2. Create a custom configuration (NOT URLSession.shared)
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30.0
        
        // 3. Inject 'self' as the delegate so we can intercept security challenges
        self.session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }
    
    // A generic network caller using Combine
    public func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        return session.dataTaskPublisher(for: url)
            .tryMap { output in
                // Standard HTTP status code validation
                guard let response = output.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension LiveNetworkManager {
    
    public func urlSession(_ session: URLSession,
                           didReceive challenge: URLAuthenticationChallenge,
                           completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        // 1. Ensure it's an SSL trust challenge
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
              let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // 2. MODERN WAY (iOS 14+): Extract the public key directly
        guard let serverPublicKey = SecTrustCopyKey(serverTrust) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // 3. Hash the key (Assuming you have a helper method that does SHA256 + Base64)
        let extractedHash = hashKey(serverPublicKey)
        
        // 4. The Backup Pin Strategy
        let pinnedKeys = [
            "WoiVQ3/x+z/9+b+xyz/activeHash=", // Primary
            "Kx82J/9a+1+x/abc/backupHash="    // Backup
        ]
        
        // 5. The Check
        if pinnedKeys.contains(extractedHash) {
            // Success
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
        } else {
            // MITM Attack detected
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
    
    private func hashKey(_ key: SecKey) -> String {
        // Implementation for converting SecKey -> Data -> SHA256 -> Base64
        return "mock_extracted_hash"
    }
}
