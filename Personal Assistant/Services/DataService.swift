//
//  DataService.swift
//  Personal Assistant
//
//  Created by Mohamad Khan on 11/25/17.
//  Copyright © 2017 TheUltimates.com. All rights reserved.
//

import Foundation

class DataService{
    static let instance = DataService()
    
    private let assistanceCategories = [
        Assistance(title: "Personal Diary", imageName: "pdiary.png"),
        Assistance(title: "Locate Nearby", imageName: "mapkit.png"),
        Assistance(title: "Health Dashboard", imageName: "healthkit.png"),
        Assistance(title: "Fall Detection", imageName: "fallDetection.png"),
        Assistance(title: "Image Recognition", imageName: "imagerec.png")
    ]
    
    func getAssistance() -> [Assistance] {
        return assistanceCategories
    }
}
