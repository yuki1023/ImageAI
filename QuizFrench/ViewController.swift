//
//  ViewController.swift
//  QuizFrench
//
//  Created by Rio Abe on 2020/08/03.
//  Copyright © 2020 Rio Abe. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var eazyButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var bonjourLabel: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTransform()
        //buttonSize()
        
    }
    func labelTransform() {
        
        let deg1 = 5.0 //時計回りに10度
   
        bonjourLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI*deg1/180.0))
    }
    //func buttonSize() {
    //eazyButton.layer.cornerRadius = 10 //角の丸さ
    //eazyButton.layer.shadowOffset = CGSize(width: 3, height: 3 ) //影の大きさ
    //eazyButton.layer.shadowOpacity = 0.5  //影の薄さ
    //eazyButton.layer.shadowRadius = 10  //影の丸み
    //eazyButton.layer.shadowColor = UIColor.gray.cgColor //影の色
    
    
    
}

