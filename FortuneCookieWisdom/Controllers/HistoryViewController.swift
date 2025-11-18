//
//  HistoryViewController.swift
//  FortuneCookieWisdom
//
//  Created by Fernando Bulnes Garrorena on 11/17/25.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var favorites: [Fortune] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favorites = FortuneProvider.favoriteFortunes
        tableView.reloadData()
        checkEmptyState()
    }
    
    // MARK: - Design Configuration
    func setupDesign() {
        title = "My Wisdom Collection"
        
        let backgroundImageView = UIImageView(image: UIImage(named: "background-pattern"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.50
        tableView.backgroundView = backgroundImageView
        
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    func checkEmptyState() {
        if favorites.isEmpty {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            messageLabel.text = "Your collection is empty.\nGo crack a cookie! 🥠"
            messageLabel.textColor = .darkGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            messageLabel.sizeToFit()
            tableView.backgroundView = messageLabel
        } else {
            setupDesign()
        }
    }
    
    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FortuneCell", for: indexPath)
        let fortune = favorites[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        content.text = "\"\(fortune.text)\""
        content.textProperties.font = UIFont(name: "Georgia-Italic", size: 20) ?? UIFont.italicSystemFont(ofSize: 20)
        content.textProperties.color = .black
        content.textProperties.alignment = .center
        content.textProperties.numberOfLines = 0
        
        content.secondaryText = "— Wisdom #\(indexPath.row + 1) —"
        content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        content.secondaryTextProperties.color = .systemOrange
        content.secondaryTextProperties.alignment = .center
        content.secondaryTextProperties.transform = .uppercase
        
        var backgroundConfig = UIBackgroundConfiguration.listCell()
        backgroundConfig.backgroundColor = .white
        backgroundConfig.cornerRadius = 20
        backgroundConfig.strokeColor = .systemOrange
        backgroundConfig.strokeWidth = 2
        backgroundConfig.backgroundInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        cell.backgroundConfiguration = backgroundConfig
        cell.contentConfiguration = content
        cell.backgroundColor = .clear
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.15
        cell.layer.shadowOffset = CGSize(width: 0, height: 4)
        cell.layer.shadowRadius = 6
        cell.clipsToBounds = false
        
        return cell
    }
    
    // MARK: - Borrar
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favorites.remove(at: indexPath.row)
            FortuneProvider.favoriteFortunes = favorites
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            checkEmptyState()
        }
    }
}
