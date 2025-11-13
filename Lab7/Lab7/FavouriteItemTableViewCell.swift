//
//  FavouriteItemTableViewCell.swift
//  Lab7
//
//  Created by Assylzhan on 13.11.2025.
//

import UIKit
import AVFoundation
import AVKit
import PDFKit

class FavouriteItemTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var cellImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleTextView: UITextView!
    @IBOutlet private weak var reviewLabel: UILabel!
    @IBOutlet weak var openButton: UIButton!
    
    weak var parentVC: UIViewController?
    private static var audioPlayer = AVAudioPlayer()
    private static var currentPlayingCell: FavouriteItemTableViewCell?
    
    private var fileName: String = ""
    private var fileType: String = ""
    private var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white.withAlphaComponent(0.50)
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.50)
        selectionStyle = .none
    }

    func configure(item:FavouriteItem, parent: UIViewController, section: Int){
        titleLabel.text = item.title
        subtitleTextView.text = item.subtitle
        reviewLabel.text = "My review: \(item.review)"
        cellImageView.image = item.image
        
        parentVC = parent
        fileName=item.fileName
        fileType=item.fileType
        self.section = section
        
        switch section{
        case 0: openButton.setTitle("Watch trailer", for: .normal)
        case 1: openButton.setTitle("Play music", for: .normal)
        case 2: openButton.setTitle("Open book", for: .normal)
        case 3: openButton.setTitle("Check syllabus", for: .normal)
        default: openButton.setTitle("Open", for: .normal)
        }
    }
    
    @IBAction private func openButtonTapped(_ sender: UIButton) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileType) else { return }
        switch fileType{
            case "mp3": playAudio(url);
            case "mp4": playVideo(url)
            case "pdf": openPDF(url)
            default: print("wrong file type")
        }
    }
    
    private func playAudio(_ url: URL){
        if FavouriteItemTableViewCell.currentPlayingCell != self{
            FavouriteItemTableViewCell.audioPlayer.stop()
        }
        if FavouriteItemTableViewCell.audioPlayer.isPlaying{
            FavouriteItemTableViewCell.audioPlayer.pause()
        }
        else{
            FavouriteItemTableViewCell.audioPlayer = try! AVAudioPlayer(contentsOf: url)
            FavouriteItemTableViewCell.audioPlayer.play()
        }
        FavouriteItemTableViewCell.currentPlayingCell = self
    }
    
    private func playVideo(_ url: URL){
        if FavouriteItemTableViewCell.audioPlayer.isPlaying {
            FavouriteItemTableViewCell.audioPlayer.stop()
        }
        guard let parentVC = parentVC else {return}
        let player = AVPlayer(url: url)
        let vc = AVPlayerViewController()
        vc.player = player
        parentVC.present(vc, animated: true){
            player.play()
        }
    }
    
    private func openPDF(_ url: URL){
        guard let parentVC = parentVC else {return}
        let pdfView = PDFView(frame: parentVC.view.bounds)
        pdfView.document=PDFDocument(url: url)
        pdfView.autoScales=true
        
        let vc = UIViewController()
        vc.view = pdfView
        parentVC.present(vc,animated: true)
    }
}
