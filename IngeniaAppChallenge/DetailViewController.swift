//
//  DetailViewController.swift
//  IngeniaAppChallenge
//
//  Created by Osmar Hernández on 28/08/19.
//  Copyright © 2019 Ingenia. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var detailGist: Gist?

    @IBOutlet weak var detailWebView: WKWebView! {
        didSet {
            self.configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureView() {
        if detailGist != nil {
            let stringUrl = self.detailGist!.fileRawValue!
            
            let url = URL(string: stringUrl)
            
            let request = URLRequest(url: url!)
            
            detailWebView.load(request)
        }
    }
}
