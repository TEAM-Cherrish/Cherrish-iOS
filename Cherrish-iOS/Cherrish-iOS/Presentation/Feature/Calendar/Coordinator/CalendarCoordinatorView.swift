//
//  CalendarCoordinatorView.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/10/26.
//

import SwiftUI

struct CalendarCoordinatorView: View {
    @EnvironmentObject private var calendarCoordinator: CalendarCoordinator
    @EnvironmentObject private var tabBarCoordinator: TabBarCoordinator
    var body: some View {
        NavigationStack(path: $calendarCoordinator.path) {
            ViewFactory.shared.makeCalendarView()
                .navigationDestination(for: CalendarRoute.self) { route in
                    Group {
                        switch route {
                        case .root:
                            ViewFactory.shared.makeHomeView()
                        case .selectTreatment:
                            ViewFactory.shared.makeSelectTreatmentView()
                                .onAppear {
                                        tabBarCoordinator.isTabbarHidden = true
                                }
                        case .noTreatment:
                            ViewFactory.shared.makeNoTreatmentView()
                        case .treatment:
                            ViewFactory.shared.makeTreatmentView()
                        }
                    }
                    .navigationBarBackButtonHidden()
                }
        }
    }
}
