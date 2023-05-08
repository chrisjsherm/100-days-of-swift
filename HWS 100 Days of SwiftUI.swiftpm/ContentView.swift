import SwiftUI

struct ContentView: View {
    @State var username: String = ""
    @State var currentUser: User?
    
    func createUser(name: String) {
        currentUser = User(username: name)
    }
   
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create user")
            TextField("Enter a username", text: $username)
            
            Button("Create", action: {
                createUser(name: username)
            })
        }
        .padding(.all)
        
        Spacer()
        
        VStack(alignment: .leading) {
            if currentUser != nil {
                Text("Current user's name is \(currentUser!.username)")
                Text("Last login at \(currentUser!.lastLoginPrettyPrint)")
                    .padding(.bottom)
                
                Button("Login", action: {
                    currentUser?.login()
                })
            } else {
                Text("Create a user to get started")
            }
        }
        
        Spacer()
    }
}
