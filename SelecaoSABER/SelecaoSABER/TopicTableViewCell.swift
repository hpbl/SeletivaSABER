//
//  TopicTableViewCell.swift
//  SelecaoSABER
//
//  Created by Hilton Pintor Bezerra Leite on 26/08/17.
//  Copyright © 2017 Hilton Pintor. All rights reserved.
//

import UIKit

// Célula que mostra resumo dos tópicos
class TopicTableViewCell: ContentCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
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
        guard let topic = content as? Post else {
            fatalError("expected an object of type Post")
        }
        
        self.avatarImageView.image = topic.avatarImage
        self.titleLabel.text = topic.title
        self.authorLabel.text = topic.author
    }
}
