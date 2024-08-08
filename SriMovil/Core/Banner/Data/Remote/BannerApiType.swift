//
//  BannerApiType.swift
//  SriMovil
//
//  Created by usradmin on 7/8/24.
//

import Foundation

protocol BannerApiType {
    func makeRequest(endPoint: EndPoint) async -> Result<Data, HttpClientError>
}
