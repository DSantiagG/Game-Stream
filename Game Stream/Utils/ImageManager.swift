//
//  ImageManager.swift
//  Game Stream
//
//  Created by David Giron on 18/10/25.
//

import Foundation

import UIKit

struct ImageManager {
    private static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private static func imageURL(for imageName: String) -> URL {
        getDocumentsDirectory().appendingPathComponent(imageName)
    }
    
    static func saveImage(_ image: UIImage, withName name: String) {
        guard let data = image.jpegData(compressionQuality: 0.9) else { return }
        try? data.write(to: imageURL(for: name))
    }
    
    static func loadImage(named name: String) -> UIImage? {
        UIImage(contentsOfFile: imageURL(for: name).path)
    }
    
    static func deleteImage(named name: String) {
        try? FileManager.default.removeItem(at: imageURL(for: name))
    }
}
