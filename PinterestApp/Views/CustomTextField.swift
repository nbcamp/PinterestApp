//
//  CustomTextField.swift
//  PinterestAppTest
//
//  Created by (^ㅗ^)7 iMac on 2023/08/16.
//

import UIKit

final class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = .white
        self.textColor = .black
        self.attributedPlaceholder = NSAttributedString(string: "텍스트를 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        self.leftViewMode = .always
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
