//
//  syrupDailyView.swift
//  syrup
//
//  Created by Caio Soares on 12/05/22.
//

import SwiftUI
import CoreData

let screenSize: CGRect = UIScreen.main.bounds

struct projectModel: Identifiable {
    var id = UUID()
    var projectName: String
    var projectColor: String
    var startingTimeSlotIndex: Int
    var timeSlotDuration: Int
}

struct hourText: View {
    var timestamp: String
    
    var body: some View {
        Text(timestamp)
            .font(.footnote)
            .fontWeight(.light)
            .multilineTextAlignment(.leading)
            .lineLimit(1)
            .padding(.horizontal)
            .frame(width: screenSize.width/4)
    }
}

struct block: View {
    
    var color: Color
    var name: String? = nil
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: screenSize.width/4 * 2, height: screenSize.height/24, alignment: .center)
                .foregroundColor(color)
                //.border(.gray)
                
                //.opacity(0.1)
            Text(name ?? "")
                .fontWeight(.regular)
                
                
        }
    }
}

struct time: View {
    
    var currentHour: Int
    
    var convertedCurrentTime: String {
        var auxHourSlot: Int = 0
        var auxMinuteSlot: Int = 0
        
        auxHourSlot = currentHour / 6
        auxMinuteSlot = currentHour % 6
        
        if (auxHourSlot < 10) {
            return String("0\(auxHourSlot):\(auxMinuteSlot)0")
        } else {
            return String("\(auxHourSlot):\(auxMinuteSlot)0")
        }
        
    }
    
    var body: some View {
        hourText(timestamp: String(convertedCurrentTime))
    }
}

struct projectTimeSlotConstructor: View {
    
    @State var startingHourIndex: Int
    var taskDuration: Int

    var projectName: String?
    var projectColor: Color?
    
    var body: some View{
        ScrollView  {
            ForEach(0..<taskDuration) { i in
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                            .frame(width: screenSize.width/4 * 3, height: screenSize.height/24, alignment: .center)
                            .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.593))
                    HStack (spacing: 0) {
                        time(currentHour: startingHourIndex + (i))
                        block(color: projectColor ?? .clear, name: projectName ?? "")
                    }
                }
            }
        }
    }
}

/*
 */

 
/*

struct projectTimeSlotManager: View {
    
    @FetchRequest(sortDescriptors:[]) private var projectsCD: FetchedResults<ProjectCD>
    
    var clearStart: Int = 0
    
    var body: some View {
        VStack {
            ForEach (projectsCD, id :\.self) { (project) in
                
                var clearDuration: Int = Int(project.startingTimeSlotIndex)
                
                projectTimeSlotConstructor(startingHourIndex: clearStart, taskDuration: clearDuration)
                
                projectsCD
                
            }
        }
    }
}
 
 */

//Proper view
 
struct syrupDailyView: View {
    
    @State private var showProjectAddView = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    //@FetchRequest(entity: ProjectCD, sortDescriptors: []) var projectsCD: FetchedResults<ProjectCD>
    
    
    
    /*@FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    */
    
    //private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            HStack {
                    ScrollView {
                        //projectTimeSlotManager()
                        projectTimeSlotConstructor(startingHourIndex: 0, taskDuration: 36, projectName: "Dormindo")
                        projectTimeSlotConstructor(startingHourIndex: 36, taskDuration: 6, projectName: "Getting ready", projectColor: Color(hue: 0.223, saturation: 0.235, brightness: 0.797))
                        projectTimeSlotConstructor(startingHourIndex: 42, taskDuration: 6, projectName: "Transportation", projectColor: Color(hue: 0.137, saturation: 0.486, brightness: 0.965))
                        projectTimeSlotConstructor(startingHourIndex: 48, taskDuration: 24, projectName: "Academy", projectColor: Color(hue: 0.908, saturation: 1.0, brightness: 1.0))
                        projectTimeSlotConstructor(startingHourIndex: 72, taskDuration: 9, projectName: "Eat something", projectColor: .red)
                        projectTimeSlotConstructor(startingHourIndex: 81, taskDuration: 12, projectName: "IAA", projectColor: .blue)
                    }
                    .navigationTitle("Hoje")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(
                        trailing: Button("Add"){
                            self.showProjectAddView.toggle()
                        }.sheet(isPresented: $showProjectAddView) {
                            projectAddView(showProjectAddView: self.$showProjectAddView)
                        })
                }
        }
    }
}

struct projectAddView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var showProjectAddView: Bool
    
    @State private var name: String = ""
    @State private var color: String = ""
    @State private var AUXstartingIndex: String = ""
    @State private var AUXduration: String = ""
    
    @State private var startingIndex: Int16 = 0
    @State private var duration: Int16 = 0
    
    var body: some View {
        Form {
            Section {
                Text("Nome do Projeto")
                TextField("ie: Estudar Geometria", text: $name)
            }
            Section {
                Text("Cor do Projeto")
                TextField("ie: .red", text: $color)
            }
            Section {
                Text("Index do horário de início")
                TextField("ie: 72", text: $AUXstartingIndex)
            }
            Section {
                Text("Duração")
                TextField("ie: 12", text: $AUXduration)
            }
        }
        Button("Adicionar"){
            self.showProjectAddView = false
            let newProjectCD = ProjectCD(context: viewContext)
            
            startingIndex = Int16(AUXstartingIndex)!
            duration = Int16(AUXduration)!
            
            newProjectCD.projectName = name
            newProjectCD.projectColor = color
            newProjectCD.startingTimeSlotIndex = startingIndex
            newProjectCD.timeSlotDuration = duration
        }
    }
}

struct syrupDailyView_Previews: PreviewProvider {
    static var previews: some View {
        syrupDailyView()
    }
}
