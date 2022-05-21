//
//  LogManager.swift
//  MainApp
//
//  Created by HuyQuoc on 07/05/2022.
//

import Foundation
import XCGLogger

public let log: XCGLogger = XCGLogger.default

struct LogConfiguration {
    
}

class LogManager {
    static func configLog(configuration: LogConfiguration){
        var logLevel: XCGLogger.Level = .none
        
        switch Environment.current {
        case Environment.debug:
            logLevel = .verbose
        case Environment.staging:
            logLevel = .info
        case Environment.production:
            logLevel = .severe
        }
        
        log.setup(level: logLevel, showLogIdentifier: false, showFunctionName: true, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, showDate: true)
        
        let emojiLogFormatter = PrePostFixLogFormatter()
        emojiLogFormatter.apply(prefix: "🗯🗯🗯 ", postfix: "", to: .verbose)
        emojiLogFormatter.apply(prefix: "🔹🔹🔹 ", postfix: "", to: .debug)
        emojiLogFormatter.apply(prefix: "ℹ️ℹ️ℹ️ ", postfix: "", to: .info)
        emojiLogFormatter.apply(prefix: "✳️✳️✳️ ", postfix: "", to: .notice)
        emojiLogFormatter.apply(prefix: "⚠️⚠️⚠️ ", postfix: "", to: .warning)
        emojiLogFormatter.apply(prefix: "‼️‼️‼️🆘 ", postfix: "", to: .error)
        emojiLogFormatter.apply(prefix: "💣💣💣 ", postfix: "", to: .severe)
        emojiLogFormatter.apply(prefix: "🛑🛑🛑 ", postfix: "", to: .alert)
        emojiLogFormatter.apply(prefix: "🚨🚨🚨 ", postfix: "", to: .emergency)
        log.formatters = [emojiLogFormatter]
        
        //Setup log files
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let logsDir = documentsPath + "/.logs"
        
        if FileManager.default.fileExists(atPath: logsDir) == false {
            do {
                try FileManager.default.createDirectory(atPath: logsDir, withIntermediateDirectories: true)
            } catch let error {
                log.error("Cannot create directory for writing log files: \(error.localizedDescription)")
                return
            }
        }
        
        let fileDestination = AutoRotatingFileDestination(
            owner: log,
            writeToFile: "\(logsDir)/app.log",
            identifier: "advancedLogger.fileDestination",
            shouldAppend: true, appendMarker: "New Session",
            attributes: nil, maxFileSize: 100240000,
            maxTimeInterval: 900,
            archiveSuffixDateFormatter: nil,
            targetMaxLogFiles: 250
        )
        
        // Optionally set some configuration options
        fileDestination.outputLevel = logLevel
        fileDestination.showLogIdentifier = false
        fileDestination.showFunctionName = true
        fileDestination.showThreadName = true
        fileDestination.showLevel = true
        fileDestination.showFileName = true
        fileDestination.showLineNumber = true
        fileDestination.showDate = true
        
        let ansiColorLogFormatter: ANSIColorLogFormatter = ANSIColorLogFormatter()
        ansiColorLogFormatter.colorize(level: .verbose, with: .colorIndex(number: 244), options: [.faint])
        ansiColorLogFormatter.colorize(level: .debug, with: .black)
        ansiColorLogFormatter.colorize(level: .info, with: .blue, options: [.underline])
        ansiColorLogFormatter.colorize(level: .warning, with: .red, options: [.faint])
        ansiColorLogFormatter.colorize(level: .error, with: .red, options: [.bold])
        ansiColorLogFormatter.colorize(level: .severe, with: .white, on: .red)
        fileDestination.formatters = [ansiColorLogFormatter]
        
        // Process this destination in the background
        fileDestination.logQueue = XCGLogger.logQueue
        
        // Add the destination to the logger
        log.add(destination: fileDestination)
    }
}
