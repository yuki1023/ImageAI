//
//  EasyQuizViewController.swift
//  QuizFrench
//
//  Created by Rio Abe on 2020/08/03.
//  Copyright © 2020 Rio Abe. All rights reserved.
//

import UIKit
import NCMB
import AVFoundation
import Kingfisher

class EasyQuizViewController: UIViewController {
    
    @IBOutlet weak var quizLabel0: UILabel!
    @IBOutlet weak var quizLabel: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var judgeImageView: UIImageView!
    @IBOutlet weak var explanationTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    var quizCount = 0
    var quizTotal = 10
    var correctCount = 0
    
    var text: String?
    
    var number = [Int]()
    var unique = [Int]()
    var answer: String?
    var explanation: String?
   
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        while unique.count < 10{
            let count = Int.random(in: 1 ..< 11)
            number.append(count)
            let orderedSet = NSOrderedSet(array: number)
            unique = orderedSet.array as! [Int]
        }
        showQuiz()
        explanationTextView.isHidden = true
        nextButton.isHidden = true
        
        
    } //次の画面
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sVC = segue.destination as! EasyScoreViewController
        sVC.correct = correctCount
        
    }
    
}
extension EasyQuizViewController: AVAudioPlayerDelegate {
    func playSound(name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("音声ファイルが見つかりません")
            return
        }
        do {
            //AVAudioPlayerのインスタンス化
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            // AVAudioPlayerのデリゲートをセット
            audioPlayer.delegate = self
            //音声の再生
            audioPlayer.play()
        } catch {
        }
    }
    
    func showQuiz() {
        quizLabel.layer.cornerRadius = 10 //角の丸さ
        quizLabel.clipsToBounds = true
        quizLabel.layer.shadowOffset = CGSize(width: 3, height: 3 ) //影の大きさ
        quizLabel.layer.shadowOpacity = 1  //影の薄さ
        quizLabel.layer.shadowRadius = 10  //影の丸み
        quizLabel.layer.shadowColor = UIColor.gray.cgColor
        //データストアから読み取る NCMB型
        let query = NCMBQuery(className: "Quiz")
        //1から8までで整数乱数
        //        let count = Int.random(in: 1 ..< 8)
        //        number.append(count)
        //絞り込み
        query?.whereKey("number", equalTo: unique[quizCount])
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                print(error)
            } else {
                let quiz = result as! [NCMBObject]
                print(self.unique, "unique")
                print(self.quizCount, "$$$$$")
                print(self.unique[self.quizCount], "%%%%")
                print(quiz, "#####")
                //最後を表示
                self.text = quiz.last?.object(forKey: "text") as? String
                self.answer = quiz.last?.object(forKey: "answer") as? String
                self.explanation = quiz.last?.object(forKey: "explanation") as? String
                //クイズラベルに表示
                self.quizLabel.text = self.text
                //この時に画像も表示
                let imageUrl = quiz.last?.object(forKey: "imageUrl") as? String
                if imageUrl != nil{
                self.quizImageView.kf.setImage(with: URL(string: imageUrl!))
                }
                self.answerButton1.setTitle("YES", for: .normal)
                self.answerButton2.setTitle("NO", for: .normal)
            }
        })
        
    }
    //解答
    func showExplanation() {
        explanationTextView.isHidden = false
        nextButton.isHidden = false
        explanationTextView.text = "解説：\(self.explanation!)"
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        
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
    
    @IBAction func nextButtonTapped() {
        answerButton1.isEnabled = true
        answerButton2.isEnabled = true
        judgeImageView.isHidden = true
        explanationTextView.isHidden = true
        nextButton.isHidden = true
        nextQuiz()
    }
    
}
