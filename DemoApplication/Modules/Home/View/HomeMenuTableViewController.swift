import UIKit
import FirebaseAuth

class HomeMenuTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, HomeMenuTableViewControllerProtocol, UITextFieldDelegate {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var logoutText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.1294, green: 0.5882, blue: 0.9529, alpha: 1.0)
        logoutText.delegate = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    @IBAction func addPhotoAction(_ sender: Any) {
        let alert = UIAlertController(title: "Add Photo", message: "Pick image from gallery or create a new photo", preferredStyle: UIAlertController.Style.alert)
        addCameraImagePickAction(alert: alert)
        addGalleryImagePickAction(alert: alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)

    }
    
    
    
    func addCameraImagePickAction(alert: UIAlertController) {
        let cameraImage = UIImage(named: "image_picker_camera")
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { UIAlertAction in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        }
        cameraAction.setValue(cameraImage, forKey: "image")
        alert.addAction(cameraAction)
    }
    
    func addGalleryImagePickAction(alert: UIAlertController) {
        let galleryImage = UIImage(named: "gallery")
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { UIAlertAction in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }
        galleryAction.setValue(galleryImage, forKey: "image")
        alert.addAction(galleryAction)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.userImage.image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func logoutAction(_ sender: Any) {
        do {
          try Auth.auth().signOut()
        } catch {
            print("Problems With Firebase SignOut")
        }
        UserDefaults().removeObject(forKey: EmailKey)
        UserDefaults().removeObject(forKey: PasswordKey)
        let splashWireframe: SplashWireframe = SplashWireframe.sharedInstance
        splashWireframe.presentLoginViewController()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Problems With Firebase SignOut")
        }
        UserDefaults().removeObject(forKey: EmailKey)
        UserDefaults().removeObject(forKey: PasswordKey)
        let splashWireframe: SplashWireframe = SplashWireframe.sharedInstance
        splashWireframe.presentLoginViewController()
        return true
    }
}
