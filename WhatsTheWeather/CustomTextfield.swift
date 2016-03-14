//
//  CustomTextfield.swift
//  WhatsTheWeather
//
//  Created by Forrest Collins on 3/13/16.
//  Copyright © 2016 Forrest Collins. All rights reserved.
//

import UIKit

class CustomTextfield: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.35)
        layer.cornerRadius = 5
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        let leftValue: CGFloat = 14
        return CGRectInset(bounds, leftValue, 0)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        let leftValue: CGFloat = 14
        return CGRectInset(bounds, leftValue, 0)
    }
}
