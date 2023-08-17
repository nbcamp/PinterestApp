//
//  CustomTextView.swift
//  PinterestAppTest
//
//  Created by (^ㅗ^)7 iMac on 2023/08/16.
//

import UIKit

final class CustomTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.text = ""
        self.textColor = .black
        self.backgroundColor = .clear
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.font = .systemFont(ofSize: 18, weight: .medium)
        self.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
