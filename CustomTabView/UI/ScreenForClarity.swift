import SwiftUI

///For easy addition of screens
struct ScreenForClarity: View {
    
    @State var name:String
    @State var pageNum:Int
    @State var backColor:Color
    
    var body: some View {
        HStack{
            VStack{
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 25.0)
                    Text("\(pageNum)")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(backColor)
                        .lineLimit(nil)
                    
                }
                .frame(width: 100.0, height: 100.0)
                Text(name)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


struct SecondScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScreenForClarity(name: "First", pageNum: 1, backColor: Color.white)
    }
}
