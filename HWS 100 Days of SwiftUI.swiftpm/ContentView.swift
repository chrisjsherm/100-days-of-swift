import SwiftUI

struct ContentView: View {
    private var employees: [(fullName: String, number: Int)]
    private var employeeCount: Int
    private var messages: [String]
    
    init() {
        employees = []
        employeeCount = 0
        messages = []
        
        printTimesTables(for: 5)
        addEmployee(firstName: "Tom", lastName: "Clancy")
    }
    
    mutating func addEmployee(firstName: String, lastName: String) {
        employeeCount += 1
        employees.append((fullName: "\(firstName) \(lastName)", number: employeeCount))
    }
    
    mutating func printTimesTables(for number: Int) {
        for i in 1...12 {
            let msg = "\(i) x \(number) is \(i * number)"
            messages.append(msg)
        }
    }
   
    var body: some View {
         ScrollView {
            VStack {
                ForEach(messages, id: \.self) { entry in
                    Text(entry)
                }
                .padding(.bottom)
                
                ForEach(employees, id: \.number) { emp in
                    Text("\(emp.number): \(emp.fullName)")
                }
            }
        }
    }
}
