//
//  ContentView.swift
//  BigBrainStorm
//
//  Created by Mateusz Zwierzchowski on 18/12/2021.
//


import SwiftUI

struct ContentView: View {
    @StateObject var nodes = Nodes()
    @StateObject var matrix = Matrix()
    @State var showSidebar: Bool = false
    @State var id = 0
    @State var currentScale: CGFloat = 0
    @State var finalScale: CGFloat = 1
    
    var body: some View {
        SideBarStack(sidebarWidth: 200, showSidebar: $showSidebar) {
            NavigationView{
                VStack(){
                    if nodes.n_array.count != 0 {
                        Form {
                            Section {
                                TextField("\(nodes.n_array[id].text)", text: $nodes.n_array[id].text)
                            } header: { Text("Text") }
                            
                            Section {
                                HStack{
                                    Text("Red")
                                    Slider(value: $nodes.n_array[id].red, in: 0...255, step: 1.0)
                                }
                                
                                HStack{
                                    Text("Green")
                                    Slider(value: $nodes.n_array[id].green, in: 0...255, step: 1.0)
                                }
                                
                                HStack{
                                    Text("Blue")
                                    Slider(value: $nodes.n_array[id].blue, in: 0...255, step: 1.0)
                                }
                                
                            } header: { Text("Color") }
                            
                            Section {
                                List {
                                    Picker("Shape", selection: $nodes.n_array[id].shape) {
                                        Text("Circle").tag(ChooseSchape.circle)
                                        Text("Rectangle").tag(ChooseSchape.rectangle)
                                    }
                                }
                            } header: { Text("Shape") }
                            
                            Section {
                                if nodes.n_array[id].shape == .circle {
                                    HStack{
                                        Text("Radius")
                                        Slider(value: $nodes.n_array[id].height, in: 32...100, step: 1.0)
                                    }
                                } else {
                                    HStack{
                                        Text("Height")
                                        Slider(value: $nodes.n_array[id].height, in: 32...100, step: 1.0)
                                    }
                                    
                                    HStack{
                                        Text("Width")
                                        Slider(value: $nodes.n_array[id].width, in: 32...100, step: 1.0)
                                    }
                                }
                                
                            } header: { Text("Size") }
                            
                            Section {
                                
                                ForEach(nodes.n_array) { i in
                                    if id != i.id {
                                        HStack {
                                            Spacer()
                                            Text(i.text)
                                            Spacer()
                                            Button(action:
                                                    {
                                                matrix.arr[id][i.id] = !matrix.arr[id][i.id]
                                                matrix.arr[i.id][id] = matrix.arr[id][i.id]
                                            }) {
                                                if matrix.arr[id][i.id] {
                                                    Text("ON").fontWeight(.bold).ONStyle()
                                                }
                                                else {
                                                    Text("OFF").fontWeight(.bold).OFFStyle()
                                                }
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                            }header: { Text("Connections") }
                            
                        }
                        
                        HStack(){
                            Button(action:
                                    {
                                matrix.deleteNode(id: id)
                                id = nodes.deleteNode(id: id)
                                
                            }) {
                                
                                Text("Delete").deleteStyle()
                                
                            }
                        }
                    }
                }
            }
            
        } content: {
            
            NavigationView {
                ZStack{
                    ZStack {
                        ForEach(nodes.n_array) { x in
                            ForEach(nodes.n_array) { y in
                                if matrix.arr[x.id][y.id] {
                                    makeLine(from: nodes.n_array[x.id], to: nodes.n_array[y.id])
                                }
                            }
                        }
                        
                        ForEach($nodes.n_array) { $node in
                            node.drawShape()
                                .gesture(DragGesture()
                                            .onChanged { value in
                                    node.offsetX = value.translation.width
                                    node.offsetY = value.translation.height
                                }
                                            .onEnded { value in
                                    node.x += node.offsetX
                                    node.y += node.offsetY
                                    node.offsetX = 0
                                    node.offsetY = 0
                                }
                                )
                                .onTapGesture(count: 2){
                                    withAnimation{
                                        showSidebar = true
                                        id = node.id
                                    }
                                }
                        }
                    }
                }
            }
            
            Button(action:
                    {
                var nodesSave: String = "["
                for i in 0..<nodes.n_array.count {
                    nodesSave += """
                                {
                                    "id": \(nodes.n_array[i].id),
                                    "x": \(nodes.n_array[i].x),
                                    "y": \(nodes.n_array[i].y),
                                    "text": \"\(nodes.n_array[i].text)\",
                                    "red": \(nodes.n_array[i].red),
                                    "green": \(nodes.n_array[i].green),
                                    "blue": \(nodes.n_array[i].blue),
                                    "shape": \"\(nodes.n_array[i].shape)\",
                                    "width": \(nodes.n_array[i].width),
                                    "height": \(nodes.n_array[i].height)
                                },
                            """
                }
                nodesSave += "]"
                
                var edgesSave: String = "["
                for x in 0..<matrix.arr.count {
                    for y in x+1..<matrix.arr.count {
                        if matrix.arr[x][y] {
                            edgesSave += """
                                        
                                        {
                                            "n1": \(x),
                                            "n2": \(y)
                                        },
                                        """
                        }
                    }
                }
                edgesSave += "]"
                
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let dataPath = documentsDirectory.appendingPathComponent("BrainStormSaves")
                
                do {
                    try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
                } catch let error as NSError {
                    print("Error creating directory: \(error.localizedDescription)")
                }
                
                let filename1 = dataPath.appendingPathComponent("asdfX.json")
                let filename2 = dataPath.appendingPathComponent("asdfY.json")
                
                print(filename1.path)
                print(filename2.path)
                
                
                do {
                    try nodesSave.write(to: filename1, atomically: true, encoding: String.Encoding.utf8)
                } catch {
                    
                }
                
                
                do {
                    try edgesSave.write(to: filename2, atomically: true, encoding: String.Encoding.utf8)
                } catch {
                }
            }) {
                Text("Save").saveStyle()
                
            }
            .position(x: UIScreen.main.bounds.width * 69/100, y: 20)
            
            Button(action:
                    {
                nodes.n_array.append(Node(id: nodes.n_array.count, x: 30, y: 30, text: "New", red: 190, green: 190, blue: 190, shape: ChooseSchape.circle))
                id = nodes.n_array.count-1
                matrix.arr.append(Array(repeating: false, count: nodes.n_array.count))
                for i in (0..<nodes.n_array.count-1)  {
                    self.matrix.arr[i].append(false)
                }
            }) {
                Text("Add+").addStyle()
            }
            .position(x: UIScreen.main.bounds.width * 89/100, y: 20)
            
        }
    }
}


struct ContentView_Previews: PreviewProvider{
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
