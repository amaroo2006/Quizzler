//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    //Defines the array of questions
    let allQuestions = QuestionBank()
    
    //Defaults the picked answer to false
    var pickedAnswer : Bool = false
    
    //Defaults the question number to the first question
    var questionNumber : Int = 0
    
    //Defaults the score to 0
    var score : Int = 0
    
    //@IBOutlet variables
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Loads the first question
        nextQuestion()
        //Sets score
        updateUI()
        
    }

    //MARK: Check for the buttons being pressed
    @IBAction func answerPressed(_ sender: AnyObject) {
        //Check which button the user pressed
        if sender.tag == 1 {
            pickedAnswer = true
        }
        
        else if sender.tag == 2 {
            
            pickedAnswer = false
            
        }
        //Check if the answer is correct
        checkAnswer()
        
        //Move to the next question
        questionNumber += 1
        nextQuestion()
        
    }
    //MARK: Methods
    
    //MARK: UpdateUI method
    func updateUI() {
        //Update score
        scoreLabel.text = "Score: \(score)"
        
        //Update progress label
        progressLabel.text = "\(questionNumber + 1) / 13"
        
        //Update progress bar
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
      
    }
    
    //MARK: Next question method
    func nextQuestion() {
        
        //Check if it is possible to go to the net question
        
        if questionNumber <= 12 {
            //Change the text of the question label to the current question while questionNumber <= 12
            questionLabel.text = allQuestions.list[questionNumber].questionText
            
            //Update the UI to show current score and progress
            updateUI()
            
        }
        //Otherwise run an alert to let the player restart the game
        else {
            
            //Create the alert
            let alert = UIAlertController(title: "Awesome", message: "You finished all the questions. Do you want to start over?", preferredStyle: .alert)
            //Give it an action and call it
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            //Present the alert
            alert.addAction(restartAction)
            present(alert, animated:true, completion: nil)
            
        }
        
    }
    
    
    
    //MARK: Check answer method
    func checkAnswer() {
        
        //Find the correct answer of the question
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        
        //Compare to what the user picked
        if correctAnswer == pickedAnswer {
            //Correct answer
            
            ProgressHUD.showSuccess("Correct!")
            score += 1

        }
        
        else {
            //Wrong answer
            ProgressHUD.showError("Wrong!")
            
        }
        
        
    }

    //MARK: Start over method
    func startOver() {
        //Restart game
        
        //Reset questionNumber
        questionNumber = 0
        
        //Reset the score
        score = 0
        
        nextQuestion()
        
    }
    

    
}
