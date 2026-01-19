//
//  OnboardingInterface.swift
//  Cherrish-iOS
//
//  Created by Cherrish on 1/18/26.
//

import Foundation

protocol OnboardingInterface {
    func createProfile(name: String, age: Int) async throws -> ProfileEntity
}
