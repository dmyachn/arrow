//
//  ViewController.swift
//  PresentVC
//
//  Created by MyachinGarpix on 13.03.2023.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    lazy var button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .red
        view.setTitle("Present", for: .normal)
        view.setTitleColor(.systemCyan, for: .normal)
        view.addTarget(self, action: #selector(tap(_:)), for: .touchUpInside)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    func setupView(){
        view.backgroundColor = .white
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 15),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func tap(_ sender: UIButton){
        let vc = PopupVC()

        let ppc = vc.popoverPresentationController
        ppc?.permittedArrowDirections = .up
        ppc?.delegate = self
        ppc?.sourceView = sender

        present(vc, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

class PopupVC: UIViewController{
    override var modalPresentationStyle: UIModalPresentationStyle {
        get { return .popover }
        set { self.modalPresentationStyle = UIModalPresentationStyle.popover} }
    
    lazy var button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        view.tintColor = .systemCyan
        view.imageView?.contentMode = .scaleAspectFill
        view.addTarget(self, action: #selector(tap(_:)), for: .touchUpInside)
        return view
    }()

    
    lazy var segmentControl: UISegmentedControl = {
        let view = UISegmentedControl (items: ["280pt","150pt"])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(valueChange(_:)), for: .valueChanged)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        preferredContentSize = CGSize(width: 300, height: 280)

        setupView()
    }
    
    func setupView(){
        view.backgroundColor = .white
        
        view.addSubview(segmentControl)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.centerYAnchor.constraint(equalTo: segmentControl.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            button.widthAnchor.constraint(equalToConstant: 30),
            button.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    @objc func valueChange(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            preferredContentSize = CGSize(width: 300, height: 280)
        default:
            preferredContentSize = CGSize(width: 300, height: 150)
        }
    }
    
    @objc func tap(_ sender: UIButton){
        dismiss(animated: true)
    }
}
