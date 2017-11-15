import UIKit

class ViewController: UIViewController {

    private let championService = ChampionService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLocalChampionData()
        fetchProgramData()
//        fetchRemoteChampionData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchLocalChampionData() {
        let filePath = Bundle.main.path(forResource: "champion", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath), options: .uncached)

        do {
            let championSkeleton = try OurDecoders.iso8601milliSeconds.decode(ChampionSkeleton.self, from: data)
            let champion = Champion(from: championSkeleton)
            
            print("IT WORKS! IT'S ALIVE ------ \(champion.name) has an image with height: \(champion.banner.height)")
        } catch {
            print("\(error)")
        }
    }
    
    func fetchProgramData() {
        let filePath = Bundle.main.path(forResource: "program", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath), options: .uncached)

        do {
            let programSkeleton = try OurDecoders.iso8601milliSeconds.decode(ProgramSkeleton.self, from: data)
            let program = Program(from: programSkeleton)
            
            print("IT WORKS? I just tried to parse \(program.title) that has \(program.numberOfSections) sections and was written by \(program.champion.name)")
            print("Linearize that stuff... \(program.linearizedSections().count)")
        } catch {
            print("\(error)")
        }
    }

    func fetchRemoteChampionData() {
        championService.getChampion(byId: 5202) { result in
            switch result {
            case let .success(champion):
                print("Fetched a champion!! \(champion.name)")
            case .failure:
                return
            }
        }
    }
}
