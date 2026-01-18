//
//  ChallengeInterface.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/19/26.
//

import Foundation

protocol ChallengeInterface {
    func fetchHomecareRoutines(completion: @escaping (Result<[ChallengeRoutineDTO], Error>) -> Void
    )
} 
