//
//  ContentView.swift
//  PinterestAppTest
//
//  Created by (^ㅗ^)7 iMac on 2023/08/16.
//

import UIKit

final class ContentView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
