//
//  CommentTableViewCell.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

class CommentTableViewCell: ContentCell {

    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setupInterface(with content: Content) {
        guard let comment = content as? Comment else {
            fatalError("expected a Comment object")
        }
        
        self.avatarImageView.image = UIImage(from: comment.avatar)
        self.authorLabel.text = comment.author
        self.commentTextView.text = comment.message
    }

}
