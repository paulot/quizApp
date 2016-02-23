//
//  ViewController.swift
//  Quiz
//
//  Created by Paulo Tanaka on 2/3/16.
//  Copyright © 2016 Paulo Tanaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet var currentQuestionLabel: UILabel!
  @IBOutlet var nextQuestionLabel: UILabel!
  @IBOutlet var answerLabel: UILabel!

  @IBOutlet var currentQuestionLabelXConstraint: NSLayoutConstraint!
  @IBOutlet var nextQuestionLabelXConstraint: NSLayoutConstraint!

  let questions: [String] = ["From what is Cognac made?",
                             "What is 7+7?",
                             "What is the capital of Vermont?"]
  let answers: [String] = ["Grapes", "14", "Montpelier"]
  var currentQuestionIndex = 0

  // MARK: Actions
  @IBAction func showNextQuestion(action: AnyObject) {
    if ++currentQuestionIndex >= questions.count {
      currentQuestionIndex = 0
    }

    nextQuestionLabel.text = questions[currentQuestionIndex]
    answerLabel.text = "???"

    animateLabelTransition()
  }

  @IBAction func showAnswer(action: AnyObject) {
    answerLabel.text = answers[currentQuestionIndex]
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    currentQuestionLabel.text = questions[currentQuestionIndex]

    updateOffScreenLabel()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    nextQuestionLabel.alpha = 0
  }

  func updateOffScreenLabel() {
    let screenWidth = view.frame.width
    nextQuestionLabelXConstraint.constant = -screenWidth
  }

  func animateLabelTransition() {
    view.layoutIfNeeded()

    let screenWidth = view.frame.width
    self.nextQuestionLabelXConstraint.constant = 0
    self.currentQuestionLabelXConstraint.constant += screenWidth

    UIView.animateWithDuration(0.5, delay: 0, options: [.CurveLinear], animations: {
      self.currentQuestionLabel.alpha = 0
      self.nextQuestionLabel.alpha = 1

      self.view.layoutIfNeeded()
      }, completion: { _ in
        swap(&self.nextQuestionLabel, &self.currentQuestionLabel)
        swap(&self.currentQuestionLabelXConstraint, &self.nextQuestionLabelXConstraint)

        self.updateOffScreenLabel()
    })
  }

}

