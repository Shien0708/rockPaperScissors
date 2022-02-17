//
//  ViewController.swift
//  rockPaperScissor
//
//  Created by 方仕賢 on 2022/2/17.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var playerPointsLabel: UILabel!
    @IBOutlet weak var compPointsLabel: UILabel!
    
    var comp = 0
    var playerPoints = 0
    var compPoints = 0
    
    var paperImageNames = ["paperRock-", "paperScissors-", "paperPaper-"]
    var scissorsImageNames = ["scissorsPaper-", "scissorsRock-", "scissorsScissors-"]
    var rockImageNames = ["rockScissors-", "rockPaper-", "rockRock-"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func showImage(_ imageName: String){
        gifImageView.image = UIImage.animatedImageNamed(imageName, duration: 9)
    }
    
    @IBAction func playerThrow(_ sender: UIButton) {
        
        //讓按鈕頁面消失
        buttonsView.isHidden = true
        
        //隨機給電腦一個值
        comp = Int.random(in: 0...2)
        
        //根據玩家按鈕顯示玩家的拳
        switch sender {
        case buttons[0]:
            showImage(rockImageNames[comp])
            
        case buttons[1]:
            showImage(paperImageNames[comp])
            
        case buttons[2]:
            showImage(scissorsImageNames[comp])
            
        default:
            print("Something Went Wrong")
        }
        
        //出現結果頁面
        let _ = Timer.scheduledTimer(timeInterval: 9, target: self, selector: #selector(showResult), userInfo: nil, repeats: false)
        
    }
    
    
    @objc func showResult(){
        //顯示頁面
        resultView.isHidden = false
        
        //根據電腦的隨機值判斷輸贏
        switch comp {
        case 0:
            resultLabel.text = "You Won!"
            playerPoints += 1
        case 1:
            resultLabel.text = "The Computer Won!"
            compPoints += 1
        case 2:
            resultLabel.text = "It's Tie!"
        default:
            print("Something Went Wrong.")
        }
        
        //更新分數顯示
        playerPointsLabel.text = "\(playerPoints)"
        compPointsLabel.text = "\(compPoints)"
    }
    
    //更新頁面
    func updateView(){
        resultView.isHidden = true
        for i in 0...buttons.count-1{
            buttons[i].isHidden = false
        }
        buttonsView.isHidden = false
    }
    
    //再玩一次按鈕
    @IBAction func again(_ sender: Any) {
        updateView()
    }
    
    //重置按鈕
    @IBAction func reset(_ sender: Any) {
        
        //顯示提示提醒玩家是否要重置
        let controller = UIAlertController(title: "Reset the Game", message: "The scores will be reset!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .default) { action in
            self.playerPoints = 0
            self.compPoints = 0
            self.updateView()
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        controller.addAction(action)
        controller.addAction(action2)
        
        present(controller, animated: true, completion: nil)
    }
}

