//
//  SwiftUIUtils.swift
//  AniHyou
//
//  Created by Axel Lopez on 19/6/22.
//

import Foundation
import SwiftUI
#if os(iOS)
import RichText
#endif

extension Color {
    
    init?(_ hex: String?) {
        guard var str = hex
        else { return nil }
        
        if str.hasPrefix("#") {
            str.removeFirst()
        }
        if str.count == 3 {
            str = String(repeating: str[str.startIndex], count: 2)
            + String(repeating: str[str.index(str.startIndex, offsetBy: 1)], count: 2)
            + String(repeating: str[str.index(str.startIndex, offsetBy: 2)], count: 2)
        } else if !str.count.isMultiple(of: 2) || str.count > 8 {
            return nil
        }
        
        guard let color = UInt64(str, radix: 16)
        else { return nil }
        
        if str.count == 2 {
            let gray = Double(Int(color) & 0xFF) / 255
            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)
        } else if str.count == 4 {
            let gray = Double(Int(color >> 8) & 0x00FF) / 255
            let alpha = Double(Int(color) & 0x00FF) / 255
            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)
        } else if str.count == 6 {
            let red = Double(Int(color >> 16) & 0x0000FF) / 255
            let green = Double(Int(color >> 8) & 0x0000FF) / 255
            let blue = Double(Int(color) & 0x0000FF) / 255
            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
        } else if str.count == 8 {
            let red = Double(Int(color >> 24) & 0x000000FF) / 255
            let green = Double(Int(color >> 16) & 0x000000FF) / 255
            let blue = Double(Int(color >> 8) & 0x000000FF) / 255
            let alpha = Double(color & 0x000000FF) / 255
            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
        } else {
            return nil
        }
    }
}

#if os(iOS)
extension RichText {
    func defaultStyle() -> RichText {
        self
            .imageRadius(8)
            .linkColor(light: .accentColor, dark: .accentColor)
            .placeholder {
                ProgressView()
            }
    }
}


var spoilerCss =
    """
    .markdown_spoiler {
        color: grey;
        background-color: grey;
    }

    .markdown_spoiler:hover, .markdown_spoiler:focus, .markdown_spoiler:active {
        background-color: transparent;
    }
    """

func shareSheet(url: String) {
    let url = URL(string: url)
    let activityView = UIActivityViewController(activityItems: [url!], applicationActivities: nil)

    let allScenes = UIApplication.shared.connectedScenes
    let scene = allScenes.first { $0.activationState == .foregroundActive }

    if let windowScene = scene as? UIWindowScene {
        windowScene.keyWindow?.rootViewController?.present(activityView, animated: true, completion: nil)
    }

}
#endif
