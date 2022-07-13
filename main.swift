import Foundation
import Just



let IG = Insta()
func main() {
    let username = input(arg: "What is your username: ")
    let password = input(arg: "What is your password: ")
    do {
        try IG.login(username: username, password: password)
        print("Logged in!")
        clear()
        while IG.logged(){
            let target = input(arg: "\n\nEnter target user: ")
            let search = try IG.search(username: target)
            clear()
            print("[-] Info for username: \(target) \n\nUser ID: \(search.user_id)\nName: \(search.name)\nPfp: \(search.pfp)\nBio: \(search.bio)\nFollowers: \(search.followers)\nFollowing: \(search.following)\nPrivate: \(search.priv)\nAge: \(search.data)")
        }
    }
    catch {
        print(error)
    }
    
}

main()

