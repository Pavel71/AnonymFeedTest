//
//  ApiServiceTest.swift
//  AnonymFeedTestTests
//
//  Created by Павел Мишагин on 05.07.2021.
//

import XCTest
@testable import AnonymFeedTest


class ApiServiceTest: XCTestCase {

 // need write several test for first
    // 3 filters
    var sut: APIService!
    
    
    override func setUp() {
        super.setUp()
        sut = APIService()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    // MARK: - End Points
    func testFirst20PostsEndPoint() {
        let endpoint = Endpoint.first(20)
        
        let result = "https://k8s-stage.apianon.ru/posts/v1/posts?first=20"
        XCTAssertEqual(endpoint.absoluteURL?.absoluteString, result)
    }
    
    func testmostPopularEndPoint() {
        let endpoint = Endpoint.orderBy("mostPopular")
        
        let result = "https://k8s-stage.apianon.ru/posts/v1/posts?orderBy=mostPopular"
        XCTAssertEqual(endpoint.absoluteURL?.absoluteString, result)
    }
    
    func testmostCommentedEndPoint() {
        let endpoint = Endpoint.orderBy("mostCommented")
        
        let result = "https://k8s-stage.apianon.ru/posts/v1/posts?orderBy=mostCommented"
        XCTAssertEqual(endpoint.absoluteURL?.absoluteString, result)
    }
    
    func testcreatedAtEndPoint() {
        let endpoint = Endpoint.orderBy("createdAt")
        
        let result = "https://k8s-stage.apianon.ru/posts/v1/posts?orderBy=createdAt"
        XCTAssertEqual(endpoint.absoluteURL?.absoluteString, result)
    }
    
    func testAfterEndPoint() {
        let endpoint = Endpoint.after("someCursor")
        
        let result = "https://k8s-stage.apianon.ru/posts/v1/posts?after=someCursor"
        XCTAssertEqual(endpoint.absoluteURL?.absoluteString, result)
    }
    
    // MARK: - Fetch First20
    
    func testFetchFirst20posts() {
        let endpoint = Endpoint.first(20)
        
        checkFetchApiData(endpoint: endpoint)
    }
    
    func testFetchMostPopularPosts() {
        let endpoint = Endpoint.orderBy("mostPopular")
        
        checkFetchApiData(endpoint: endpoint)
    }
    
    func testFetchMostCommentedPosts() {
        let endpoint = Endpoint.orderBy("mostCommented")
        
        checkFetchApiData(endpoint: endpoint)
    }
    
    func testFetchCreatedAtposts() {
        let endpoint = Endpoint.orderBy("createdAt")
        
        checkFetchApiData(endpoint: endpoint)
    }
    
    
    
    
    private func checkFetchApiData(endpoint: Endpoint) {
        var checkResult: WelcomeData?
        var checkError: Error?
        sut.fetch(from: endpoint) { result in
            switch result {
            case .failure(let error):
                checkError = error
            case .success(let apiModel):
                checkResult = apiModel.data
            }
            
            XCTAssertNotNil(checkResult)
            XCTAssertNil(checkError)
        }
    }
    
}
