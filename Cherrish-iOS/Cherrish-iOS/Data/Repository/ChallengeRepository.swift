//
//  ChallengeRepository.swift
//  Cherrish-iOS
//
//  Created by sumin Kong on 1/19/26.
//

import Foundation

import Alamofire

struct DefaultChallengeRepository: ChallengeInterface {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchHomecareRoutines(
        completion: @escaping (Result<[ChallengeRoutineDTO], Error>) -> Void
    ) {
        let url = "\(Environment.baseURL)/api/challenges/homecare-routines"

        AF.request(url, method: .get)
            .validate()
            .responseDecodable(
                of: BaseResponseDTO<[ChallengeRoutineDTO]>.self
            ) { response in
                switch response.result {
                case .success(let decoded):
                    guard let routines = decoded.data else {
                        completion(.success([]))
                        return
                    }
                    completion(.success(routines))

                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

