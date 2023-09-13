//
//  ViewController.swift
//  ChacthTheGumballGame
//
//  Created by Can Armağan on 3.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    var score = 0
    var highScore = 0
    var counter = 0
    var timer = Timer()
    var hideTimer = Timer()
    var gumballArray = [UIImageView]()
    
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var gumball1: UIImageView!
    @IBOutlet weak var gumball2: UIImageView!
    @IBOutlet weak var gumball3: UIImageView!
    @IBOutlet weak var gumball4: UIImageView!
    @IBOutlet weak var gumball5: UIImageView!
    @IBOutlet weak var gumball6: UIImageView!
    @IBOutlet weak var gumball7: UIImageView!
    @IBOutlet weak var gumball8: UIImageView!
    @IBOutlet weak var gumball9: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = String(score)
        
        //HighScore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscoree")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        
        //Images
        gumball1.isUserInteractionEnabled = true
        gumball2.isUserInteractionEnabled = true
        gumball3.isUserInteractionEnabled = true
        gumball4.isUserInteractionEnabled = true
        gumball5.isUserInteractionEnabled = true
        gumball6.isUserInteractionEnabled = true
        gumball7.isUserInteractionEnabled = true
        gumball8.isUserInteractionEnabled = true
        gumball9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        gumball1.addGestureRecognizer(recognizer1)
        gumball2.addGestureRecognizer(recognizer2)
        gumball3.addGestureRecognizer(recognizer3)
        gumball4.addGestureRecognizer(recognizer4)
        gumball5.addGestureRecognizer(recognizer5)
        gumball6.addGestureRecognizer(recognizer6)
        gumball7.addGestureRecognizer(recognizer7)
        gumball8.addGestureRecognizer(recognizer8)
        gumball9.addGestureRecognizer(recognizer9)
        
        gumballArray = [gumball1, gumball2, gumball3, gumball4, gumball5, gumball6, gumball7, gumball8, gumball9]
        
        
        //Tiimers
        counter = 15
        timeLabel.text = "Time: \(counter)"
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideGumball), userInfo: nil, repeats: true)
        
        hideGumball()
    }
    
    @objc func hideGumball() {
        
        for gumball in gumballArray {
            gumball.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(gumballArray.count - 1)))
        gumballArray[random].isHidden = false
    }
    
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    
    @objc func timerFunction() {
        
        counter -= 1
        timeLabel.text = String(counter)

        if counter == 0 {
            
            hideTimer.invalidate()
            timer.invalidate()
            timeLabel.text = "Time's Over"
            
            for gumball in gumballArray {
                gumball.isHidden = true
            }
            
            //HighgScore
            
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscoree")
            }
            
            
            //ALERT
            let alert = UIAlertController(title: "Süre Doldu", message: "Tekrar Denemek İster Misin?", preferredStyle: UIAlertController.Style.alert)
            let vazgecButton = UIAlertAction(title: "Vazcgeç", style: UIAlertAction.Style.cancel)
           
            
            let tekrarButton = UIAlertAction(title: "Tekrar Dene", style: .default) {
                (UIApplication) in
                // Tekrar dene function
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideGumball), userInfo: nil, repeats: true)
                              
                
            }
            
            alert.addAction(vazgecButton)
            alert.addAction(tekrarButton)
            self.present(alert, animated: true, completion: nil)
            
            
            
        }
    }
    
    
    
    

    
}
