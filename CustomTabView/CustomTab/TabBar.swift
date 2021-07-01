//  Based on Gesen
//  https://github.com/wxxsw/TabBar
//  Modifed by JackFromBB

import SwiftUI


///Simple custom TabView
@available(iOS 13.0, *)
public struct TabBar<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
    
    @Binding public var barHeight: CGFloat
    
    private var model: TabBarModel<SelectionValue>
    private let content: Content
    
    public init(_ selection: SelectionValue, _ barHeight: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
        self.model = TabBarModel(selection: selection)
        self.content = content()
        self._barHeight = barHeight
    }
    
    public var body: some View {
        VStack(spacing:0){
            ZStack{
                content
                    .environmentObject(model)
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
    public init(_ selection: SelectionValue, @ViewBuilder content: () -> Content) {
        self.init(selection, .constant(60), content: content)
    }
}

extension TabBar where SelectionValue == Int{
    public init(@ViewBuilder content: () -> Content) {
        self.init(0, .constant(60), content: content)
    }
}
