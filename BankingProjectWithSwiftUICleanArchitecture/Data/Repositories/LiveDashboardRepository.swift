//
//  LiveDashboardRepository.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 22/07/2026.
//

import Foundation
import Combine

public final class LiveDashboardRepository: DashboardRepositoryProtocol {
    
    private let networkManager: LiveNetworkManager
    private let endpointURL = URL(string: "https://api.hsbc.co.in/v1/dashboard/accounts")!
    
    // Inject the secure network manager
    public init(networkManager: LiveNetworkManager = LiveNetworkManager()) {
        self.networkManager = networkManager
    }
    
    public func fetchCustomerAccounts() -> AnyPublisher<[BankingAccount], Error> {
        // 3. Fetch the raw DTOs from the network
        return networkManager.fetch(url: endpointURL)
            .map { (dtos: [AccountDTO]) -> [BankingAccount] in
                // 4. THE MAPPER: Convert raw DTOs into pure Domain Entities
                return dtos.map { dto in
                    BankingAccount(
                        id: dto.account_id,
                        accountName: dto.name,
                        accountNumber: dto.acc_num,
                        availableBalance: dto.bal,
                        accountType: AccountType(rawValue: dto.type_code) ?? .savings
                    )
                }
            }
            .eraseToAnyPublisher()
    }
}
