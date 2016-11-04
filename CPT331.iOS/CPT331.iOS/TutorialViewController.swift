//
//  TutorialViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 2/11/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    // -----------------------------
    // MARK: Constants
    // -----------------------------
    let exitButtonTitle = (skip: "Skip >", done: "Done >")
    let pageIdentifiers = [
        "tutorialWelcome",
        "tutorialLocation",
        "tutorialAnnotaiton",
        "tutorialMenu",
        "tutorialSearch"
    ]
    
    
    
    // -----------------------------
    // MARK: Runtime Variables
    // -----------------------------
    var pageContainer: UIPageViewController!
    var pages = [UIViewController]()
    var currentIndex: Int?
    private var pendingIndex: Int?
    
    
    // -----------------------------
    // MARK: Storyboard References
    // -----------------------------
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var exitButton: UIButton!
    
    
    
    // -----------------------------
    // MARK: Main Logic
    // -----------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup pages
        let tutorialStoryboard = UIStoryboard(name: "Tutorial", bundle: nil)
        for identifier in pageIdentifiers {
            let page = tutorialStoryboard.instantiateViewControllerWithIdentifier(identifier)
            pages.append(page)
        }
        
        // Setup page container
        pageContainer = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageContainer.delegate = self
        pageContainer.dataSource = self
        pageContainer.setViewControllers([pages.first!], direction: .Forward, animated: true, completion: {void in})
        
        // Add the container to view
        view.addSubview(pageContainer.view)
        
        // Configure custom page control
        view.bringSubviewToFront(pageControl)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        
        // Configure exit button
        view.bringSubviewToFront(exitButton)
        exitButton.setTitle(exitButtonTitle.skip, forState: .Normal)
    }
    
    @IBAction func exitButtonTapped(sender: AnyObject) {
        (UIApplication.sharedApplication().delegate as? AppDelegate)?.setRootViewController(withIdentifier: "mapView", animated: true)
    }
    
    
    
    // -------------------------------------
    // MARK: UIPageViewControllerDataSource
    // -------------------------------------
    
    func pageIndex(forViewController viewController: UIViewController) -> Int? {
        return self.pages.indexOf(viewController)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if let currentIndex = pageIndex(forViewController: viewController) where currentIndex > 0 {
            let previousIndex = abs((currentIndex - 1) % pages.count)
            return pages[previousIndex]
            
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if let currentIndex = pageIndex(forViewController: viewController) where currentIndex < pages.count-1 {
            let nextIndex = abs((currentIndex + 1) % pages.count)
            return pages[nextIndex]
            
        } else {
            return nil
        }
    }
    
    
    
    // -------------------------------------
    // MARK: UIPageViewControllerDelegate
    // -------------------------------------
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        pendingIndex = pages.indexOf(pendingViewControllers.first!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed == true else {
            return
        }
        
        currentIndex = pendingIndex
        if pendingIndex != nil {
            pageControl.currentPage = pendingIndex!
        }
        
        if pendingIndex == pages.count - 1 {
            self.exitButton.setTitle(exitButtonTitle.done, forState: .Normal)
        } else {
            self.exitButton.setTitle(exitButtonTitle.skip, forState: .Normal)
        }
    }
}
