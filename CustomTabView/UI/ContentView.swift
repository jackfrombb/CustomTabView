import SwiftUI

struct ContentView: View {
    
    @State var selection = TabBarSelection(selection: 0)
    
    var body: some View {
        TabBar(selection){
            
            ScreenForClarity(name: "First", pageNum: 1, backColor: Color.white).tabBarItem(0, {
                TabItem(itemName: "First",
                        itemLogo: "heart")
            }).onTapGesture {
                selection.selection = 1
            }
            
            ScreenForClarity(name: "Second", pageNum: 2, backColor: Color.green).tabBarItem(1, {
                TabItem(itemName: "Second",
                        itemLogo: "person.crop.circle")
            })
        }
    }
}

///Tab Item Icon
struct TabItem: View {
    let tabIconSize:CGFloat = 30
    let itemName:String
    let itemLogo:String
    
    var body: some View{
        Image(systemName: itemLogo)
            .resizable(resizingMode: .stretch)
            .frame(width: tabIconSize,
                   height: tabIconSize)
        
        Text(itemName).font(.system(size: 12)).padding(1.0)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
