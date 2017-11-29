import UIKit

class ViewController: UIViewController {

    private let championService = ChampionService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        fetchLocalChampionData()
//        fetchProgramData()
//        fetchRemoteChampionData()
        
//        fetchLocalSpacePostData()
//        fetchLocalFeedPostData()
        fetchLocalSpaceData()
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
            
            print("Parse CHAMPION ------ \(champion.name) has an image with height: \(champion.banner?.height ?? 0)")
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
            
            print("Parse PROGRAM------ \(program.title) that has \(program.numberOfSections) sections and was written by \(program.champion.name). Linearized sections: \(program.linearizedSections().count)")
        } catch {
            print("\(error)")
        }
    }

    func fetchRemoteChampionData() {
        championService.getChampion(byId: 5202) { result in
            switch result {
            case let .success(champion):
                print("Parse CHAMPION ------ \(champion.name)")
            case .failure:
                return
            }
        }
    }
    
    func fetchLocalSpacePostData() {
        let filePath = Bundle.main.path(forResource: "spacePost", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath), options: .uncached)
        
        do {
            let postSkeleton = try OurDecoders.iso8601milliSeconds.decode(PostSkeleton.self, from: data)
            let post = Post(from: postSkeleton)
            
            print("Parse SPACE POST ------ \"\(post.body)\" by \(post.user?.displayName)")
        } catch {
            print("\(error)")
        }
    }
    
    func fetchLocalFeedPostData() {
        let filePath = Bundle.main.path(forResource: "feedPost", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath), options: .uncached)
        
        do {
            let postSkeleton = try OurDecoders.iso8601milliSeconds.decode(PostSkeleton.self, from: data)
            let post = Post(from: postSkeleton)
            
            print("Parse FEED POST ------ \"\(post.body)\" by \(post.user?.displayName)")
        } catch {
            print("\(error)")
        }
    }
    
    func fetchLocalSpaceData() {
        let filePath = Bundle.main.path(forResource: "space", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath), options: .uncached)
        
        do {
            let spaceSkeleton = try OurDecoders.iso8601milliSeconds.decode(SpaceSkeleton.self, from: data)
            let space = Space(from: spaceSkeleton)
            
            print("Parse SPACE ----- \(space.postCount) posts in the example space")
        } catch {
            print("\(error)")
        }
    }
}
