//
//  CommentTableViewCell.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

// célula que mostra um comentário em um tópico
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
    
    // método do protocolo, onde atualizamos o conteúdo da interface
    override func setupInterface(with content: Content) {
        guard let comment = content as? Comment else {
            fatalError("expected an object of type Comment")
        }
        
        self.avatarImageView.image = comment.avatarImage
        self.authorLabel.text = comment.author
        self.commentTextView.text = comment.message
    }

}
