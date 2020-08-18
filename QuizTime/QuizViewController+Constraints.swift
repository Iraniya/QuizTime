//
//  QuizViewController+Constraints.swift
//  QuizTime
//
//  Created by iraniya on 17/08/20.
//  Copyright © 2020 iraniya. All rights reserved.
//

import UIKit
import SnapKit

extension QuizViewController  {
    func setupConstraints() {
        
        updateProgress(to: 0)
        
        lbtTimer.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.45).labeled("timerWidth")
            make.height.equalTo(45).labeled("timerHeight")
            make.top.equalTo(viewProgress.snp.bottom).offset(32).labeled("timerTop")
            make.centerX.equalToSuperview().labeled("timerCenterX")
        }
        
        lblQuestion.snp.makeConstraints { (make) in
            make.top.equalTo(lbtTimer.snp.bottom).offset(24)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            .inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
        
        lblMessage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
       
        
        svButtons.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(lblQuestion)
            make.top.equalTo(lblQuestion.snp.bottom).offset(16)
            make.height.equalTo(80)
        }
        
    }
    
    func updateProgress(to progress: Double) {
        viewProgress.snp.remakeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().multipliedBy(progress)
            make.height.equalTo(32)
            make.leading.equalToSuperview()
        }
    }
    
}


extension QuizViewController {
    override func willTransition(to newCollection: UITraitCollection,
                                 with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        let isPortrait = UIDevice.current.orientation.isPortrait
        
        lbtTimer.snp.updateConstraints { (make) in
            make.height.equalTo(isPortrait ? 45:65)
        }
        
        lbtTimer.font = UIFont.systemFont(ofSize: isPortrait ? 20:32, weight: .light)
    }
}
