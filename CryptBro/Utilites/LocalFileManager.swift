//
//  LocalFileManager.swift
//  CryptBro
//
//  Created by karma on 6/8/22.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    private init() { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        // Create folder
        createFolderIfNeeded(folderName: folderName)
        
        // Get path for image
        guard
            let data = image.pngData(),
            let url = getUrlForImage(imageName: imageName, folderName: folderName)
        else {
            return
        }
        
        // Save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print(error.localizedDescription,"--------error saving image")
        }
        
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getUrlForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getUrlForFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            print("folder doesnt exist")
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("error creating directory------:",error.localizedDescription)
            }
        }
    }
    
    private func getUrlForFolder(folderName: String) -> URL? {
        guard
        let url = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    private func getUrlForImage(imageName: String, folderName: String) -> URL? {
        guard let folderUrl = getUrlForFolder(folderName: folderName) else {
            return nil
        }
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
    
}
