//
//  StringExtensions.swift
//  codeChallenge
//
//  Created by Nancy on 18/05/22.
//  Copyright © 2022 Fernando Suárez. All rights reserved.
//

import Foundation

extension String {
    var htmlToAttributedString: NSAttributedString {
        guard let data = data(using: .utf8) else { return NSAttributedString(string: self) }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString(string: self)
        }
    }
}
