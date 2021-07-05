//  Based on Gesen
//  https://github.com/wxxsw/TabBar
//  Modifed by JackFromBB

import SwiftUI


///Simple custom TabView
@available(iOS 13.0, *)
struct TabBar<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
    
    @Binding var barHeight: CGFloat
    @ObservedObject private var model: TabBarSelection<SelectionValue>
    private let content: Content
    
    init(_ selection: TabBarSelection<SelectionValue>, _ barHeight: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
        self.model = selection
        self.content = content()
        self._barHeight = barHeight
    }
    
    public var body: some View {
        
        VStack(spacing:0){
            ZStack{
                content
                    .environmentObject(model)
                    .animation(.easeIn)
            }
            Divider()
            Spacer()
                .frame(height: barHeight)
                .animation(.easeIn)
        }
        .edgesIgnoringSafeArea(.bottom)
        .overlayPreferenceValue(TabBarItemPreferenceKey.self, { preferences in
            VStack(spacing: 0){
                Spacer()
                HStack(spacing: 0) {
                    ForEach(preferences) { preference in
                        VStack(spacing: 0){
                            preference.label
                                .frame(width: UIScreen.main.bounds.width / CGFloat(preferences.count))
                                .foregroundColor(self.model.selection ==
                                                    (preference.index as? SelectionValue) ? .blue : .black)
                            //FIXME: Replace .black some Color.init("TabNormal") for dark theme support
                                
                        }.onTapGesture {
                            if let i = preference.index as? SelectionValue {
                                self.model.selection = i
                            }
                        }
                    }
                }
                .frame(height: barHeight)
            }
            .animation(.easeIn)
            
            
        })
    }
}

extension TabBar{
     init(_ selection: TabBarSelection<SelectionValue>, @ViewBuilder content: () -> Content) {
        self.init(selection, .constant(60), content: content)
    }
}

extension TabBar where SelectionValue == Int{
    
    init(@ViewBuilder content: () -> Content) {
        self.init(TabBarSelection(selection: 0), .constant(60), content: content)
    }
    
    init(selection:SelectionValue, @ViewBuilder content: () -> Content){
        self.init(TabBarSelection(selection: selection), .constant(60), content: content)
    }
}
