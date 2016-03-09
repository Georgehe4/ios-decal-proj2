//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//
//Images credited to "KittieLovesBlood" on photobucket

import UIKit

class GameViewController: UIViewController {
    var incorrectGuesses: [Character]?
    var correctGuesses: [Character]?
    var phrase: String?
    
    @IBOutlet weak var incorrectGuessBox: UILabel!
    @IBOutlet weak var guessBox: UITextField!
    @IBOutlet weak var hangmanWord: UILabel!
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var guessButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        correctGuesses = [Character]()
        incorrectGuesses = [Character]()
        showGif()
        updateCorrect()
        print(phrase!)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        guessAction(textField)
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func guessAction(sender: AnyObject) {
        if guessBox.isFirstResponder() {
            guessBox.resignFirstResponder()
        }
        let guessCharacters:String = guessBox.text!
        if guessCharacters.characters.count != 1 {
            invalidInputAlert()
            return
        }
        else {
            let guessCharacter:Character = guessCharacters.capitalizedString.characters.first!
            guessLetter(guessCharacter)
        }
        guessBox.text = ""
    }
    
    func invalidInputAlert() {
        let alert = UIAlertController(title: "Invalid Input", message: "Enter a single character!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func duplicateInputAlert() {
        let alert = UIAlertController(title: "Duplicate Input", message: "You've already guessed that character!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func guessLetter(character: Character) {
        if incorrectGuesses!.contains(character) || correctGuesses!.contains(character) {
            duplicateInputAlert()
        }
        else if phrase!.characters.contains(character) {
            correctGuesses!.append(character)
            updateCorrect()
        }
        else {
            incorrectGuesses!.append(character)
            updateIncorrect()
        }
    }
    
    func updateCorrect() {
        let correctWord = buildCorrectWord()
        hangmanWord.text = correctWord
    }
    
    func updateIncorrect() {
        showGif()
        showIncorrectLetters()
    }
    
    func winnerAlert() {
        let alert = UIAlertController(title: "You Win!", message: "Congrats! You've won! The word was: '\(phrase!)'", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showIncorrectLetters() {
        var stringRep = "Incorrect Guesses: "
        for i in 0...incorrectGuesses!.count - 1{
            stringRep+="\(incorrectGuesses![i])"
            if i != incorrectGuesses!.count - 1 {
                stringRep += ", "
            }
        }
        incorrectGuessBox.text = stringRep
    }
    
    func showGif() {
        let incorrectGuessCount = incorrectGuesses!.count
        //Images credited to "KittieLovesBlood" on photobucket
        let newSource = "hangman\(incorrectGuessCount).png"
        hangmanImage.image = UIImage(named: newSource)
    }
    
    func buildCorrectWord () -> String {
        var filledWord:String = ""
        var everMatched = true
        let newPhrase = phrase!.stringByReplacingOccurrencesOfString(" ", withString: "\n")
        for i in newPhrase.characters {
            var matched = false
            for j in correctGuesses! {
                if i == j{
                    matched = true
                    filledWord += "\(String(i)) "
                    break
                }
            }
            if (i == "\n") {
                filledWord += "\n"
            }
            if (!matched) {
                everMatched = false
                filledWord += "_ "
            }
        }
        if everMatched {
            winnerAlert()
        }
        return filledWord
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
