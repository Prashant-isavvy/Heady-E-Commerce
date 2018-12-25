//
//  BaseViewController.swift
//  HeadyApp
//
//  Created by Apple on 23/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var loadingBGView : UIView?
    var activityIndicator : UIActivityIndicatorView?
    var loadingLabel : UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setUpScreenLayout(){
        
    }
    
    // MARK: - Navigation methods
    func viewController(withStoryboard name:StoryBoard, controllerName: ViewController) -> UIViewController {
        let storyboard = UIStoryboard.init(name: name.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: controllerName.rawValue)
    }
    func pushViewController(withStoryboard name:StoryBoard, controllerName: ViewController ,isAnimate:Bool) {
        let storyboard = UIStoryboard.init(name: name.rawValue, bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: controllerName.rawValue)
        self.navigationController?.pushViewController(viewcontroller, animated: isAnimate)
    }
    // MARK: - Loader methods
    func showLoadingIndicator(isOnCompleteScreen:Bool = true, color: UIColor = UIColor.blue, lodingText:String = "")
    {
        if (loadingBGView==nil)
        {
            let bounds = self.view.bounds
            loadingBGView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height+30))
            loadingBGView?.backgroundColor = UIColor.black
            loadingBGView?.alpha = 0.3
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            loadingLabel = UILabel(frame: CGRect.zero)
            loadingLabel?.textAlignment = NSTextAlignment.center
            loadingLabel?.font = UIFont.systemFont(ofSize: 17.0)
            loadingLabel?.textColor = UIColor.white
        }
        DispatchQueue.main.async {
            self.activityIndicator?.color = color
        }
        if (isOnCompleteScreen && loadingBGView != nil){
            DispatchQueue.main.async {
                self.activityIndicator?.center = (self.loadingBGView?.center)!
                self.loadingBGView?.isHidden = false
                self.loadingBGView?.addSubview(self.activityIndicator!)
            }
            
            loadingLabel?.frame = CGRect(x: 0, y: self.view.frame.size.height/2 + 47, width: self.view.bounds.size.width, height: 20)
            loadingBGView?.addSubview(loadingLabel!)
            if let window = UIApplication.shared.keyWindow{
                window.addSubview(loadingBGView!)
            }else{
                if (self.navigationController?.viewControllers.contains(self)) != nil
                {
                    self.navigationController?.view.addSubview(loadingBGView!)
                }
                else
                {
                    self.view.addSubview(loadingBGView!)
                    
                }
            }
            
        }else{
            activityIndicator?.center = self.view.center
            loadingLabel?.frame = CGRect(x: 0, y: (activityIndicator?.frame.size.height)! + (activityIndicator?.frame.origin.y)!, width: self.view.bounds.size.width, height: 20)
            self.view.addSubview(activityIndicator!)
            self.view.addSubview(loadingLabel!)
        }
        loadingLabel?.text = lodingText
        activityIndicator?.isHidden = false
        activityIndicator?.startAnimating()
    }
    func hideLoadingIndicator(){
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
            self.activityIndicator?.isHidden = true
            self.loadingBGView?.isHidden = true
        }
    }
    
}
