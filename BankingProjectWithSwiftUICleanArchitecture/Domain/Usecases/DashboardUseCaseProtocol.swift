//
//  DashboardUseCaseProtocol.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 23/07/2026.
//


import Foundation
import Combine

public protocol DashboardUseCaseProtocol {
    func execute() -> AnyPublisher<[BankingAccount], Error>
}
