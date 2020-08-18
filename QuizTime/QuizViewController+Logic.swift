//
//  QuizViewController+Logic.swift
//  QuizTime
//
//  Created by iraniya on 17/08/20.
//  Copyright © 2020 iraniya. All rights reserved.
//


import UIKit

extension QuizViewController {
    @objc func handleAnswer(_ sender: UIButton) {
        let userrSelection = sender == btnTrue
        let isCorrect = state.question.isTrue == userrSelection
        
        if isCorrect {
            state.correctAnswers += 1
        }
        
        showMessage(isCorrect: isCorrect)
    }
    
    func showMessage(isCorrect: Bool) {
        lblMessage.text = isCorrect ? "That's correct!\n👍🎉😄" : "Sorry, that's wrong!\n\n👎☠️😢"
        lblMessage.textColor = isCorrect ? .green : .red
        lblMessage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        lblMessage.alpha = 0
        timer?.invalidate()
        
        UIView.animate(withDuration: 0.7,
                       delay: 0.0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseIn ,
                       animations: {
                        self.lblMessage.alpha = 1
                        self.lblMessage.transform = .identity
        }, completion: { _ in
            UIView.animate(withDuration: 0.15,
                           delay: 0.35,
                           animations: {
                            self.lblMessage.alpha = 0
            }) { _ in
                self.goToNextQuestion()
            }
        })
    }
    
    func goToNextQuestion() {
        guard !state.isLastQuestion else {
            //This is the  last question
            let message = state.correctAnswers > 10 ? "Good Job" : "Try again"
            let alert = UIAlertController(title: message,
                                          message: "You got \(state.correctAnswers) out of \(state.numberOfQuestions) right.",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Start Over", style: .default, handler: { [weak self] _  in self?.startGame() }))
            present(alert, animated: true, completion: nil)
            return
        }
        goToNextQuestion(at: state.currentQuestion + 1)
    }
    
    func goToNextQuestion(at position: Int) {
        state.currentQuestion = position
        
        lblQuestion.text = state.question.title
        navigationItem.title = " \(position)/\(state.numberOfQuestions)"
        
        let progress = Double(position) / Double(state.numberOfQuestions)
        updateProgress(to: progress)
        startCountdown()
    }
    
    func startGame() {
        state = State(questions: questions)
        goToNextQuestion(at: 1)
    }
    
    func startCountdown() {
        lbtTimer.text  = "00:10"
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] (timer) in
            guard let self = self else { return }
            let currentSeconds = Int((self.lbtTimer.text ?? "0").replacingOccurrences(of: ":", with: "")) ?? 1
            
            guard currentSeconds > 1 else {
                timer.invalidate()
                self.goToNextQuestion()
                return
            }
            
            self.lbtTimer.text = "00:0\(currentSeconds - 1)"
        })
    }
}


