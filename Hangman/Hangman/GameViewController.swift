//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

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
        print(phrase)
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
        print("Invalid input")
    }
    
    func guessLetter(character: Character) {
        for i in phrase!.characters {
            if character == i {
                correctGuesses!.append(character)
                updateCorrect()
                return
            }
        }
        incorrectGuesses!.append(character)
        updateIncorrect()
    }
    
    func updateCorrect() {
        let correctWord = buildCorrectWord()
        hangmanWord.text = correctWord
    }
    
    func updateIncorrect() {
        showGif()
        showIncorrectLetters()
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
        let newSource = "hangman\(incorrectGuessCount+1).gif"
        hangmanImage.image = UIImage(named: newSource)
    }
    
    func buildCorrectWord () -> String {
        var filledWord:String = ""
        for i in phrase!.characters {
            var matched = false
            for j in correctGuesses! {
                if i == j || i == " "{
                    matched = true
                    filledWord += String(i)
                    break
                }
            }
            if (!matched) {
                filledWord += "_"
            }
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
