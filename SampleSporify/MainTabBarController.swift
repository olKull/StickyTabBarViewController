//
//  MainTabBarController.swift
//  SampleSporify
//
//  Created by Emre Havan on 20.03.20.
//  Copyright © 2020 Emre Havan. All rights reserved.
//

public protocol StickyViewControllerSupporting: UITabBarController {
    var collapsableVCFlow: ExpandableViewController? { get set }
    func configureCollapsedTrainingView(withChildViewController childViewController: Expandable)
    func removeCollapsedView()
}

extension StickyViewControllerSupporting {
    
    func configureCollapsedTrainingView(withChildViewController childViewController: Expandable) {
        guard collapsableVCFlow == nil else {
            return
        }
        childViewController.loadView()
        collapsableVCFlow = ExpandableViewController(withChildVC: childViewController,
                                                     minimisedView: childViewController.minimisedView)
        collapsableVCFlow!.tabController = self
        view.addSubview(collapsableVCFlow!.view)
        addChild(collapsableVCFlow!)
        collapsableVCFlow!.view.translatesAutoresizingMaskIntoConstraints = false
        collapsableVCFlow!.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collapsableVCFlow!.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        collapsableVCFlow!.view.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        let heightConstraint = collapsableVCFlow!.view.heightAnchor.constraint(equalToConstant: 50.0)
        heightConstraint.isActive = true
        collapsableVCFlow!.heightConstraint = heightConstraint

        collapsableVCFlow!.didMove(toParent: self)
    }
    
    func removeCollapsedView() {
        if let collapsableVCFlow = collapsableVCFlow {
            collapsableVCFlow.view.removeFromSuperview()
            collapsableVCFlow.removeFromParent()
            self.collapsableVCFlow = nil
        }
    }
}

import UIKit

class MainTabBarController: UITabBarController, StickyViewControllerSupporting {
    var collapsableVCFlow: ExpandableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
