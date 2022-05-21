//
//  NotificationTableViewCell.swift
//  MainApp
//
//  Created by HuyQuoc on 20/05/2022.
//

import UIKit

class NotificationTableViewCell: BaseTableViewCell, ReuseIdentifiable {
    //MARK: - Subviews
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createAtLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func display(_ data: NotificationItemViewModel) {
        backgroundColor = data.isRead ? UIColor.white : Asset.Colors.unreadColor.color
        thumbnailImageView.cornerRadius = thumbnailImageView.frame.height / 2
        thumbnailImageView.setImage(with: data.image)
        iconImageView.setImage(with: data.icon)
        titleLabel.text = data.title
        createAtLabel.text = data.time.toNotificationFormat()
        highlightTitleLabel(data.highlights)
    }
    
    func highlightTitleLabel(_ highlights: [(offset: Int, length: Int)]) {
        guard let attributedText = titleLabel.attributedText else { return }
        let attributed = NSMutableAttributedString(attributedString: attributedText)
        do
        {
            for highlight in highlights {
                let range: NSRange = NSRange(location: highlight.offset, length: highlight.length)
                attributed.addAttribute(NSAttributedString.Key.foregroundColor, value: Asset.Colors.titleColor.color, range: range)
                attributed.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 14), range: range)
            }
            titleLabel.attributedText = attributed
            
        }
    }

}
