//
//  ArticleViewCell.swift
//  MediaParkAssignment
//
//  Created by Komsann Ly on 6/2/22.
//

import UIKit

class ArticleViewCell: UITableViewCell {
  
  @IBOutlet weak var imgView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  func update(with article: Article) {
    titleLabel.text = article.title
    descriptionLabel.text = article.description
    imgView?.sd_setImage(with: URL(string: article.image))
  }
}
