//
//  NSAttributedStringExtension.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import UIKit

extension NSAttributedString {
    class func make(string: String,
                    font: UIFont,
                    color: UIColor,
                    paragraphStyle: NSMutableParagraphStyle? = nil,
                    underline: Bool = false,
                    colorBackground: UIColor? = nil) -> NSAttributedString {
        var textAttibutes: [NSAttributedString.Key: Any] = [.font: font,
                                                            .foregroundColor: color]
        if underline {
            textAttibutes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        if let style = paragraphStyle {
            textAttibutes[.paragraphStyle] = style
        }
        if colorBackground != nil {
            textAttibutes[.backgroundColor] = colorBackground
        }

        return NSAttributedString(string: string, attributes: textAttibutes)
    }
}
