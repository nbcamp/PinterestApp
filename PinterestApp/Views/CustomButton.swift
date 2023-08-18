//
//  CustomButton.swift
//  PinterestAppTest
//
//  Created by (^ㅗ^)7 iMac on 2023/08/16.
//

import UIKit

final class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
