//
//  CubicTransition.swift
//  CustomTransition
//
//  Created by Tibor Waxmann on 24.02.2022.
//

import SwiftUI

struct CubicTransition<Content: View, Detail: View>: View {
    // MARK: - PROPERTIES
    var content: Content
    var detail: Detail
    
    // MARK: Show View
    @Binding var show: Bool
    
    init(show: Binding<Bool>, @ViewBuilder content: @escaping () -> Content, @ViewBuilder detail: @escaping () -> Detail) {
        self.detail = detail()
        self.content = content()
        self._show = show
    }
    
    // MARK: Animation properties
    @State var animateView: Bool = false
    @State var showView: Bool = false
    
    @State var task: DispatchWorkItem?
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            HStack(spacing: 0) {
                content
                    .frame(width: size.width, height: size.height)
                // MARK: Rotating current view when detail view is pushing
                    .rotation3DEffect(.init(degrees: animateView ?  -85 : 0), axis: (x: 0, y: 1, z: 0), anchor: .trailing, anchorZ: 0, perspective: 1)
                
                // Displaying detail view
                ZStack {
                    if showView {
                        detail
                            .frame(width: size.width, height: size.height)
                            .transition(.move(edge: .trailing))
                            .onDisappear {
                                print("Closed")
                            }
                    }
                }
                .rotation3DEffect(.init(degrees: animateView ?  0 : 85), axis: (x: 0, y: 1, z: 0), anchor: .leading, anchorZ: 0, perspective: 1)
            }
            // Applying offset
            .offset(x: animateView ? -size.width : 0)
        }
        .onChange(of: show) { newValue in
            task?.cancel()
            
            // Showing view before animation start
            if show {
                showView = true
                // The view is not removed so it will create memory issues
            } else {
                // Closing view when the animation is finished
                // which is after 0.35 sec
                task = .init {
                    showView = false
                }
                if let task = task {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35, execute: task)
                }
            }
            
            // Why using separate variable instead of show
            // since it will remove as soon as it set to false
            // so the animation will not be completed
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                withAnimation(.easeInOut(duration: 0.35)) {
                    animateView.toggle()
                }
            }
        }
    }
}

// MARK: - PREVIEWS
struct CubicTransition_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
