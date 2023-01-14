//
//  HugeDataBaseServiceTest.swift
//  HugeDatabaseTests
//
//  Created by Pierre on 14/01/2023.
//

import XCTest
@testable import HugeDatabase

final class HugeDataBaseServiceTest: XCTestCase {
    // custom urlsession for mock network calls
    var urlSession: URLSession!
    var sampleData: Word!

    override func setUp() {
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        sampleData = Word(words: ["AAS","BBS","CCS"])
    }
    
    func testGetData() async throws {
        // hugeDataBaseService. Injected with custom url session for mocking
        let hugeDataBaseService = HugeDataBaseService(urlSession: urlSession)
        
        // Set mock data
        let mockData = try JSONEncoder().encode(sampleData)
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }

        let word = try await hugeDataBaseService.fetchWords()
        XCTAssertEqual(word.words[0], "AAS")
    }
    
    func testBadUrlString() async throws {
        // hugeDataBaseService. Injected with custom url session for mocking
        let hugeDataBaseService = HugeDataBaseService(urlSession: urlSession)
        
        // set blank urlString
        hugeDataBaseService.urlString = ""
        
        do {
            _ = try await hugeDataBaseService.fetchWords()
            XCTFail("error was not thrown")
        } catch {
            XCTAssertEqual(error as! NetworkingError, NetworkingError.invalidURLString)
        }
    }
    
    func testBadResponseStatusCode() async throws {
        // hugeDataBaseService. Injected with custom url session for mocking
        let hugeDataBaseService = HugeDataBaseService(urlSession: urlSession)
        
        // Set mock data
        let mockData = try JSONEncoder().encode(sampleData)
        
        // Set urlResponse statusCode 500
        let response = HTTPURLResponse(url: URL(string: hugeDataBaseService.urlString)!, statusCode: 500, httpVersion: nil, headerFields: nil)!
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        do {
            _ = try await hugeDataBaseService.fetchWords()
            XCTFail("error was not thrown")
        } catch {
            XCTAssertEqual(error as! NetworkingError, NetworkingError.serverError)
        }
    }
}
