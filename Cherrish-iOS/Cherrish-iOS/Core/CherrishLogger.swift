//
//  CherrishLogger.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 12/31/25.
//

import OSLog

extension OSLog {
    static let subsystem = Bundle.main.bundleIdentifier!
    static let network = OSLog(subsystem: subsystem, category: "Network")
    static let debug = OSLog(subsystem: subsystem, category: "Debug")
    static let data = OSLog(subsystem: subsystem, category: "Data")
    static let error = OSLog(subsystem: subsystem, category: "Error")
}

enum LogType {
    case network
    case debug
    case data
    case error(error: Error)
    
    var category: String {
        switch self {
        case .network:
            return "Network"
        case .debug:
            return "Debug"
        case .data:
            return "Data"
        case .error:
            return "Error"
        }
    }
    
    var osLog: OSLog {
        switch self {
        case .network:
            return OSLog.network
        case .debug:
            return OSLog.debug
        case .data:
            return OSLog.data
        case .error:
            return OSLog.error
        }
    }
    
    var osLogType: OSLogType {
        switch self {
        case .network, .data:
            return .default
        case .debug:
            return .debug
        case .error:
            return .error
        }
    }
    
    var shouldShowLogInRelease: Bool {
        switch self {
        case .error:
            true
        default:
            false
        }
    }
}

struct CherrishLogger {
    private static var isDebugMode: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    private static func shouldShowLog(type: LogType) -> Bool {
        if isDebugMode { return true }
        
        return type.shouldShowLogInRelease
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    private static var timestamp: String {
        dateFormatter.string(from: Date())
    }
    
    static private func log(
        type: LogType,
        message: Any,
        file: String,
        function: String
        
    ) {
        guard shouldShowLog(type: type) else { return }
        
        let logger = Logger(subsystem: OSLog.subsystem, category: type.category)
        let logMessage = "\(message)"
        let fileName = (#file as NSString).lastPathComponent
        
        switch type {
        case .network:
            logger.log("[🛜 Network] [Date: \(timestamp)] [\(fileName) -> \(function)]: \(logMessage)")
        case .debug:
            logger.debug("[🐛 Debug] [Date: \(timestamp)] [\(fileName) -> \(function)]: \(logMessage)")
        case .data:
            logger.info("[📊 Data] [Date: \(timestamp)] [\(fileName) -> \(function)]: \(logMessage)")
        case .error(let error):
            logger.error("[❌ Error] [Date: \(timestamp)] [\(fileName) -> \(function)]: \(error.localizedDescription)")
            
        }
    }
    
    static func network(
        _ message: Any,
        file: String = #file,
        function: String = #function
    ) {
        log(type: .network, message: message, file: file, function: function)
    }
    
    static func debug(
        _ message: Any,
        file: String = #file,
        function: String = #function
    ) {
        log(type: .debug, message: message, file: file, function: function)
    }
    
    static func data(
        _ message: Any,
        file: String = #file,
        function: String = #function
    ) {
        log(type: .data, message: message, file: file, function: function)
    }
    
    static func error(
        _ error: Error,
        file: String = #file,
        function: String = #function
    ) {
        log(type: .error(error: error), message: "", file: file, function: function)
    }
}
