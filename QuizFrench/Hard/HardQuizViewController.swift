//
//  HardQuizViewController.swift
//  QuizFrench
//
//  Created by Rio Abe on 2020/08/05.
//  Copyright © 2020 Rio Abe. All rights reserved.
//

import UIKit
import NCMB
import AVFoundation
import Kingfisher

class HardQuizViewController: UIViewController {
    
    @IBOutlet weak var quizTextView: UITextView!
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var explanationTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var judgeImageView: UIImageView!
    
    var quizCount = 0
    var quizTotal = 5
    var correctCount = 0
    
    var number = [Int]()
    var unique = [Int]()
    var answer: String?
    var explanation: String?
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        while unique.count < 5{
            let count = Int.random(in: 1 ..< 6)
            number.append(count)
            let orderedSet = NSOrderedSet(array: number)
            unique = orderedSet.array as! [Int]
        }
        showQuiz()
        explanationTextView.isHidden = true
        nextButton.isHidden = true
        
    }
    //次の画面
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sVC = segue.destination as! HardScoreViewController
        sVC.correct = correctCount
        
    }
}
extension HardQuizViewController: AVAudioPlayerDelegate {
    func playSound (name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("音声ファイルが見つかりません")
            return
        }
        do {
            //AVAudioPlayerのインスタンス化
            audioPlayer = try
                AVAudioPlayer(contentsOf:URL(fileURLWithPath: path))
            // AVAudioPlayerのデリゲートをセット
            audioPlayer.delegate = self
            //音声の再生
            audioPlayer.play()
        } catch {
        }
    }
    func showQuiz() {
        quizTextView.layer.cornerRadius = 10 //角の丸さ
        quizTextView.layer.shadowOffset = CGSize(width: 3, height: 3 ) //影の大きさ
        quizTextView.layer.shadowOpacity = 1  //影の薄さ
        quizTextView.layer.shadowRadius = 10  //影の丸み
        quizTextView.layer.shadowColor = UIColor.gray.cgColor //影の色
        //データストアから読み取る NCMB型
        let query = NCMBQuery(className: "HardQuiz")
        //絞り込み
        query?.whereKey("number", equalTo: unique[quizCount])
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                print(error)
            } else {
                let quiz = result as! [NCMBObject]
                //最後を表示
                let text = quiz.last?.object(forKey: "text") as! String
                let answerButton1 = quiz.last?.object(forKey: "answerButton1") as! String
                let answerButton2 = quiz.last?.object(forKey: "answerButton2") as! String
                let answerButton3 = quiz.last?.object(forKey: "answerButton3") as! String
                let answerButton4 = quiz.last?.object(forKey: "answerButton4") as! String
                self.answer = quiz.last?.object(forKey: "answer") as! String
                self.explanation = quiz.last?.object(forKey: "explanation") as! String
                //クイズラベルに表示
                self.quizTextView.text = text
                //この時に画像も表示
                let imageUrl = quiz.last?.object(forKey: "imageUrl") as! String
                self.quizImageView.kf.setImage(with: URL(string: imageUrl))
                self.answerButton1.setTitle("\(answerButton1)", for: .normal)
                self.answerButton2.setTitle("\(answerButton2)", for: .normal)
                self.answerButton3.setTitle("\(answerButton3)", for: .normal)
                self.answerButton4.setTitle("\(answerButton4)", for: .normal)
            }
        })
    }
    //解答
    func showExplanation() {
        explanationTextView.isHidden = false
        nextButton.isHidden = false
        explanationTextView.text = "解説：\(self.explanation!)"
        //explanationTextView.alpha = 0.0
        //UIView.explanationTextView.animate(withDuration: 0.5, delay: 1.0, options: [.curveEaseIn], animations: {
        //self.explanationTextView.alpha = 1.0}, completion: nil)
        
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        
    }
    //続くorスコア画面に遷移
    func nextQuiz() {
        quizCount += 1
        if quizCount < quizTotal {
            showQuiz()
        } else {
            performSegue(withIdentifier: "toScore", sender: nil)
        }
        
    }
    @IBAction func selectAnswerButton1() {
        if answerButton1.titleLabel?.text == self.answer {
            correctCount += 1
            judgeImageView.image = UIImage(named: "correct")
            playSound(name: "QuizCorrectAnswer")
        } else {
            judgeImageView.image = UIImage(named: "incorrect")
            playSound(name: "QuizWrongAnswer")
        }
        judgeImageView.isHidden = false
        showExplanation()
    }
    
    @IBAction  func selectAnswerButton2() {
        if answerButton2.titleLabel?.text == self.answer {
            correctCount += 1
            judgeImageView.image = UIImage(named: "correct")
            playSound(name: "QuizCorrectAnswer")
        } else {
            judgeImageView.image = UIImage(named: "incorrect")
            playSound(name: "QuizWrongAnswer")
        }
        judgeImageView.isHidden = false
        showExplanation()
    }
    
    @IBAction  func selectAnswerButton3() {
        if answerButton3.titleLabel?.text == self.answer {
            correctCount += 1
            judgeImageView.image = UIImage(named: "correct")
            playSound(name: "QuizCorrectAnswer")
        } else {
            judgeImageView.image = UIImage(named: "incorrect")
            playSound(name: "QuizWrongAnswer")
        }
        judgeImageView.isHidden = false
        showExplanation()
    }
    @IBAction  func selectAnswerButton4() {
        if answerButton4.titleLabel?.text == self.answer {
            correctCount += 1
            judgeImageView.image = UIImage(named: "correct")
            playSound(name: "QuizCorrectAnswer")
        } else {
            judgeImageView.image = UIImage(named: "incorrect")
            playSound(name: "QuizWrongAnswer")
        }
        judgeImageView.isHidden = false
        showExplanation()
        
    }
    
    @IBAction func nextButtonTapped() {
        let screenHeight = Double(UIScreen.main.bounds.size.height)
        //UIView.animate(withDuration: 0.5, animations: {() -> Void in self.explanationBGView.frame = CGRect(x: self.explanationBGX, y: screenHeight, width: 320, height: 210) })
        answerButton1.isEnabled = true
        answerButton2.isEnabled = true
        answerButton3.isEnabled = true
        answerButton4.isEnabled = true
        judgeImageView.isHidden = true
        explanationTextView.isHidden = true
        nextButton.isHidden = true
        nextQuiz()
    }
    
}

