//
//  HardScoreViewController.swift
//  QuizFrench
//
//  Created by Rio Abe on 2020/08/10.
//  Copyright © 2020 Rio Abe. All rights reserved.
//

import UIKit

class HardScoreViewController: UIViewController {
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var tresBienLabel: UILabel!
    
    var correct = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "\(correct)問正解！"
        labelTransform()
        
    }
    func labelTransform() {
        let deg2 = -10.0
        tresBienLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI*deg2/180.0))
        
    }
    @IBAction func toTitleButtonAction(_ sender: Any) {
        //showで画面遷移
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Title") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

  

}
