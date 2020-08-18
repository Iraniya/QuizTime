//
//  State.swift
//  QuizTime
//
//  Created by iraniya on 17/08/20.
//  Copyright © 2020 iraniya. All rights reserved.
//

import Foundation

extension QuizViewController {
    
    struct State {
        let questions: [Question]
        let numberOfQuestions: Int
        var currentQuestion: Int
        var correctAnswers: Int
        
        init(questions: [Question]) {
            self.questions = questions
            numberOfQuestions = questions.count
            currentQuestion = 1
            correctAnswers = 0
        }
        
        var isLastQuestion:  Bool  {
            return  currentQuestion  == numberOfQuestions
        }
        
        var question: Question {
            return questions[currentQuestion - 1]
        }
    }
}


//extension QuizViewController {
//  struct State {
//    let questions: [Question]
//    let numberOfQuestions: Int
//    var currentQuestion: Int
//    var correctAnswers: Int
//
//    init(questions: [Question]) {
//      self.questions = questions
//      numberOfQuestions = questions.count
//      currentQuestion = 1
//      correctAnswers = 0
//    }
//
//    var isLastQuestion: Bool {
//      return currentQuestion == numberOfQuestions
//    }
//
//    var question: Question {
//      return questions[currentQuestion - 1]
//    }
//  }
//}
