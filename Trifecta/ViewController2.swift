//
//  ViewController2.swift
//  Trifecta
//
//  Created by Mike Dix on 4/19/19.
//  Copyright © 2019 Mike Dix. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    var activePlayer = 1 //Cross
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    var gameIsActive = true
    
    @IBOutlet weak var labelWinner: UILabel!
    @IBOutlet weak var action: UIButton!
    
    @IBAction func action(_ sender: UIButton) {
        
        if (gameState[sender.tag-1] == 0 && gameIsActive == true)
        {
            gameState[sender.tag-1] = activePlayer
            
            if (activePlayer == 1)
            {
                sender.setImage(UIImage(named: "blackX"), for:UIControl.State())
                activePlayer = 2
            }
            else
            {
                sender.setImage(UIImage(named: "blackO"), for:UIControl.State())
                activePlayer = 1
            }
        }
        
        for combination in winningCombinations
        {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]
            {
                gameIsActive = false
                
                if gameState[combination[0]] == 1
                {
                    //Cross won
                    labelWinner.text = "Cross has won!"
                }
                else
                {
                    //naught won
                    labelWinner.text = "Naught has won!"

                }
                
                playAgainButton.isHidden = false
                labelWinner.isHidden = false
            }
        }
        gameIsActive = false
        
        for i in gameState   //draw
        {
            if i == 0
            {
                gameIsActive = true
                break
            }
        }
        if gameIsActive == false
        {
            labelWinner.text = "It's a Draw!"
            labelWinner.isHidden = false
            playAgainButton.isHidden = false
        }
    }
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBAction func playAgain(_ sender: Any)
    {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameIsActive = true
        activePlayer = 1
        
        playAgainButton.isHidden = true
        labelWinner.isHidden = true
        
        for i in 1...9
        {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // action(UIButton.init())


        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
