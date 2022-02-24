//
//  Home.swift
//  CustomTransition
//
//  Created by Tibor Waxmann on 24.02.2022.
//

import SwiftUI

struct Home: View {
    // MARK: - PROPERTIES
    @State var show: Bool = false

    // MARK: - BODY
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            CubicTransition(show: $show) {
                    ZStack {
                        Image("pic1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipped()
                        
//                        Button {
//                            show.toggle()
//                        } label: {
//                            Text("Navigate")
//                                .font(.title3)
//                                .foregroundColor(.white)
//                                .padding()
//                                .background(.ultraThinMaterial)
//                                .cornerRadius(10)
//                                .environment(\.colorScheme, .dark)
//                        }
                    }
                } detail: {
                    Image("pic2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                }

        }
        .ignoresSafeArea()
        .overlay(alignment: .top) {
            HStack(spacing: 12) {
                if show {
                    Button {
//                        show.toggle()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                
                Text(show ? "Back" : "Custom transition")
                    .font(.title.bold())
                    .foregroundColor(.white)
            }
            .padding()
            .padding(.top, 4)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.ultraThinMaterial)
            .environment(\.colorScheme, .dark)
        }
        .onTapGesture {
            show.toggle()
        }
    }
}

// MARK: - PREVIEWS
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
