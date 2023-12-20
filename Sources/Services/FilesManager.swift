//
//  FilesManager.swift
//  InstaStoryDemo
//
//  Created by Nam Nguyen on 8/15/20.
//  Copyright © 2020 Nam Nguyen. All rights reserved.
//

import Foundation
import RxSwift

enum FileExtension: String, Codable {
    case jpg
    case png
    case json
}

struct ResourceManager {
    func getURL(by name: String?, fileExtension: FileExtension?) -> URL? {
        return Bundle.main.url(forResource: name, withExtension: fileExtension?.rawValue)
    }
}

let resourceManager = ResourceManager()

struct FilesManager {
    static func loadFile<T: Codable>(from fileName: String) -> T? {
        do {
            guard let url = resourceManager.getURL(by: fileName, fileExtension: .json) else {
                return nil
            }
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }
}
