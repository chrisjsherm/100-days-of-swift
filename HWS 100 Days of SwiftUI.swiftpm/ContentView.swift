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
        
        do {
            try addEmployee(firstName: "Tom", lastName: "Clancy")
        } catch {
            print("An error occurred adding the employee")
        }
        
        print("Hello world")
        let val = 100
        do {
            let res = try checkpointFn(val: val)
            print("Result: \(res)")
        } catch {
            print("Error occurred calling checkpoint function with value \(val)")
            print(error.localizedDescription)
        }
    }
    
    func checkpointFn(val: Int) throws -> Int {
        if (val < 1) {
            throw RangeError.outside
        } else if (val > 10_000) {
            throw RangeError.outside
        }
        
        var hi = 100
        var lo = 2
        while hi >= lo {
            let mid = (hi + lo) / 2
            print("Hi: \(hi), Lo: \(lo), Mid: \(mid)")
            let res = mid * mid
            if res == val {
                return mid
            }
            
            print("result: \(res)")
            if res > val {
                hi = mid - 1
            } else {
                lo = mid + 1
            }
        }
                
        throw NoRootError.noIntRoot
    }
    
    mutating func addEmployee(firstName: String, lastName: String) throws {
        if (firstName == "" && lastName == "") {
            throw EmployeeError.emptyNames
        }
        
        if (firstName == "") {
            throw EmployeeError.emptyFirstName
        }
        
        if (lastName == "") {
            throw EmployeeError.emptyLastName
        }
        
        
        employeeCount += 1
        employees.append((fullName: "\(firstName) \(lastName)", number: employeeCount))
    }
    
    mutating func printTimesTables(for number: Int, end: Int = 10) {
        for i in 1...end {
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
