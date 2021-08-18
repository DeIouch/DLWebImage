//
//  ImageLoader.swift
//  Kingfisher
//
//  Created by onevcat on 2018/11/18.
//
//  Copyright (c) 2019 Wei Wang <onevcat@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

struct ImageLoader {
    static let sampleImageURLs: [String] = {
        let prefix = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/Loading"
        return (1...10).map { "\(prefix)/kingfisher-\($0).jpg" }
    }()
    
    static let orientationImageURLs: [String] = {
        let prefix = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/Orientation"
        return (1...16).map { "\(prefix)/\($0).jpg" }
    }()

    static let highResolutionImageURLs: [String] = {
        let prefix = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/HighResolution"
        return (1...20).map { "\(prefix)/\($0).jpg" }
    }()
    
    static let gifImageURLs: [String] = {
        let prefix = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/GIF"
        return (1...3).map { "\(prefix)/\($0).gif" }
    }()

    static let progressiveImageURL: String = {
        let prefix = "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/Progressive"
        return "\(prefix)/progressive.jpg"
    }()
    
    static func roseImage(index: Int) -> String {
        return "https://github.com/onevcat/Flower-Data-Set/raw/master/rose/rose-\(index).jpg"
    }
}
