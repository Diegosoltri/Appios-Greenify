//
//  PerfilViewController.swift
//  Greenify
//
//  Created by Jose Galindo on 04/11/24.
//

import UIKit

class PerfilViewController: UIViewController {

    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var location: UIStackView!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var career: UILabel!
    @IBOutlet weak var name: UIStackView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var topBackgroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
