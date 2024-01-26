import UIKit
import RealmSwift
import AVFoundation

final class HomeViewController: UIViewController {

    @IBOutlet private weak var selectButton: UIButton!
    @IBOutlet private weak var createButton: UIButton!
    @IBOutlet private weak var modeButton: UIButton!
    
    @IBAction func selectButton(_ sender: UIButton) {
        audioPlayer?.stop()
    }
    @IBAction func createButton(_ sender: UIButton) {
        audioPlayer?.stop()
    }
    
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //この画面に戻ってきたら常時再生されるようにする
        playSoundWithVolume(name: "テーマソング", type: "mp3", volume: 0.7)
    }
    
    func configureButton() {
        selectButton.layer.cornerRadius = selectButton.bounds.width / 11
        createButton.layer.cornerRadius = createButton.bounds.width / 11
        modeButton.layer.cornerRadius = modeButton.bounds.width / 11
    }
    
    func playSoundWithVolume(name: String, type: String, volume: Float) {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.volume = volume
                audioPlayer?.play()
                audioPlayer?.numberOfLoops = -1
            } catch {
                print("再生失敗")
            }
        }
    }
}
