//
//  StringExtension.swift
//  PhotoGalleryApp
//
//  Created by Adrian Rodzic on 27/08/2023.
//

import Foundation

extension String {
    func replacePolishCharacters() -> String {
        var sanitized = self

        let polishCharacterMap: [Character: Character] = [
            "ą": "a",
            "ć": "c",
            "ę": "e",
            "ł": "l",
            "ń": "n",
            "ó": "o",
            "ś": "s",
            "ź": "z",
            "ż": "z",
            "Ą": "A",
            "Ć": "C",
            "Ę": "E",
            "Ł": "L",
            "Ń": "N",
            "Ó": "O",
            "Ś": "S",
            "Ź": "Z",
            "Ż": "Z",
        ]

        for (polishChar, replacementChar) in polishCharacterMap {
            sanitized = sanitized.replacingOccurrences(of: String(polishChar), with: String(replacementChar))
        }

        return sanitized
    }
}
