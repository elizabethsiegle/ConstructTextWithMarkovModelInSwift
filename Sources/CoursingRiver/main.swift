import Vapor
import Foundation

let app = try Application()
let router = try app.make(Router.self)

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
    return "nice! got it!"
}
try app.run()
