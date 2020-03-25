//
//  GistsViewController.swift
//  IngeniaAppChallenge
//
//  Created by Osmar Hernández on 28/08/19.
//  Copyright © 2019 Ingenia. All rights reserved.
//

import UIKit

class GistsViewController: UIViewController {

    @IBOutlet weak var gistsTableView: UITableView!
    
    var store: GistStore!
    private var gist: Gist?
    
    var timer: Timer!
    var refreshControl: UIRefreshControl!
    
    var fetchedGists = [Gist]() {
        didSet {
            self.gistsTableView.reloadData()
        }
    }
    
    private let detailSegueIdentifier = "detailSegue"
    private let gistsCellIdentifier = "gistsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timer = Timer.scheduledTimer(timeInterval: 900.0, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
        
        self.refreshControlSetup()
        self.callWebService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = self.gistsTableView.indexPathForSelectedRow {
            self.gistsTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier {
            let detailVC = segue.destination as! DetailViewController
            detailVC.detailGist = gist
        }
    }
    
    @objc func refresh() {
        self.callWebService()
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
    
    private func refreshControlSetup() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = UIColor.darkGray
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.gistsTableView.addSubview(refreshControl)
    }
    
    private func callWebService() {
        store.fetchingGists {
            (gistsResult) in
            
            switch gistsResult {
            case let .success(gists):
                self.fetchedGists = gists.sorted(by: { $0.date!.compare($1.date!) == .orderedDescending })
            case let .failure(error):
                print("Error fetching gists: \(error)")
            }
        }
    }
    
    let formatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.dateStyle = .medium
        return df
    }()
}

extension GistsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedGists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gist = fetchedGists[indexPath.row]
        let gistsCell = tableView.dequeueReusableCell(withIdentifier: self.gistsCellIdentifier) as! GistsTableViewCell
        
        gistsCell.loginLabel.text = gist.login
        gistsCell.fileNameLabel.text = gist.fileName
        gistsCell.descriptionLabel.text = gist.description
        gistsCell.commentsLabel.text = "\(gist.comments)"
        
        if let date = gist.date {
            gistsCell.createdDateLabel.text = formatter.string(from: date)
        }
        
        if let url = URL(string: gist.ownerImageURL) {
            store.getOwnerImage(url) { (data, error) in
                guard let data = data else { return }
                
                if let image = UIImage(data: data) {
                    gistsCell.avatarImage.image = image
                    gistsCell.setNeedsLayout()
                }
            }
        }
        
        return gistsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gist = fetchedGists[indexPath.row]
        performSegue(withIdentifier: detailSegueIdentifier, sender: self)
    }
}
