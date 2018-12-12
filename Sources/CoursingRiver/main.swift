import Vapor
import Foundation

let app = try Application()
let router = try app.make(Router.self)
var audienceMadeArr: [String] = []
//let drop = try Droplet()

   // Create an HTTP Response with the twiml as the body.
   // var resp = HTTPResponse(status: .ok, body: twiml)
   // resp.contentType = .xml
   // return resp

router.post("serversidesms") { req -> String in
    let words = ["mulan", "swift", "coursing", "river", "ios", "developer", "as", "a", "make", "build", "code", "text", "message", "phone", "call", "cell", "princess", "hamilton", "thank", "you"]
    
    //print(req.content.syncDecode(String.self))
    var body: String =  try req.content.syncGet(at: "Body")
    body = body.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    
    guard words.contains(body) else {
        return "send one of these words: \(words)"
    }
    audienceMadeArr.append(body)
    print(audienceMadeArr)
    let fileName = "audiencemade.txt"
    var filePath = ""
    let dirs: [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.desktopDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
    if dirs.count > 0 {
        let dir = dirs[0] //docs dir
        filePath = dir.appending("/" + "ios/CoursingRiver/CoursingRiver/" + fileName)
        print("Local path = \(filePath)")
    } else {
        print("could not find local dir to store file")
        //return
    }
    let formattedArr = (audienceMadeArr.map{String($0)}).joined(separator: ",")
    let fileContentToWrite = String(formattedArr)
    do {
        try fileContentToWrite.write(toFile: filePath, atomically: false, encoding: String.Encoding.utf8)
    }
    catch let err as NSError {
        print("error took place: \(err)")
    }
//    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//
//        let fileURL = dir.appendingPathComponent(file)
//
//        //writing
//        do {
//            try body.write(to: fileURL, atomically: false, encoding: .utf8)
//        }
//        catch {/* error handling here */}
//
//        //reading
//        do {
//            let text2 = try String(contentsOf: fileURL, encoding: .utf8)
//        }
//        catch {/* error handling here */}
//    }
    return "nice! got it!"
}
try app.run()
