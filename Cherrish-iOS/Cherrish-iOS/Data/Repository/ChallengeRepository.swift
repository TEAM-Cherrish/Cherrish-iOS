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
        completion: @escaping (Result<[RoutineEntity], Error>) -> Void
    ) {
        let url = ChallengeAPI.homecareRoutines.url

        AF.request((url), method: .get)
            .validate()
            .responseDecodable(
                of: BaseResponseDTO<[ChallengeRoutineDTO]>.self
            ) { response in
                switch response.result {
                case .success(let decoded):
                    let entities: [RoutineEntity] = decoded.data?.map { $0.toEntity()} ?? []
                    completion(.success(entities))

                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

