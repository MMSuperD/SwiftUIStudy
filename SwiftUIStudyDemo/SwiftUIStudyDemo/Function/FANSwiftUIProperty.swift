//
//  FANSwiftUI_padding.swift
//  SwiftUIStudyDemo
//
//  Created by 王丹 on 2023/6/9.
//

import SwiftUI

struct FANSwiftUIProperty: View {
    var body: some View {
        VStack{
            Group {
                FANText(text: "offset")
                FANSwiftUIProperty_Offset()
            }
            
            Group {
                FANText(text: "padding")
                FANSwiftUIProperty_padding()
            }
            
            Group {
                FANText(text: "alignmentGuide")
                FANSwiftUIProperty_alignmentGuide()
            }
            
        }
    }
}

struct FANSwiftUI_padding_Previews: PreviewProvider {
    static var previews: some View {
        FANSwiftUIProperty()
    }
}


/**
 offset 则是在渲染层面进行的位置调整，即使出现了位置变化，其他视图在布局时，并不会将其位移考虑在其中
 */
struct FANSwiftUIProperty_Offset: View {
    var body: some View{
        VStack{
            Rectangle()
                .fill(.orange)
                .frame(width: 100, height: 100, alignment: .top)
                .border(.blue, width: 10)
                .offset(y:50)
            Rectangle()
                .fill(.red)
                .frame(width: 200, height: 100, alignment: .top)
                .border(.blue, width: 10)
        }
    }
}

/**
 padding 是在布局层面进行的调整，添加 padding 后的视图，同时也会对其他视图的布局产生影响
 */
struct FANSwiftUIProperty_padding: View {
    var body: some View{
        VStack(spacing: 0){
            Rectangle()
                .fill(.orange)
                .frame(width: 100, height: 100, alignment: .top)
                .border(.blue, width: 10)
            Rectangle()
                .fill(.red)
                .frame(width: 200, height: 100, alignment: .top)
                .border(.blue, width: 10)
        }
    }
}

struct FANSwiftUIProperty_alignmentGuide: View {
    @State var show = false
    @State var greenSize: CGSize = .zero
    var body: some View{
        Color.clear
            .overlay(alignment: .bottom){
            RedView().alignmentGuide(.bottom){
                show ? $0[.bottom] + greenSize.height : $0[.bottom]
            }
            .overlay(alignment: .bottom){
                GreenView()
                    .alignmentGuide(.bottom) {
                        show ? $0[.bottom] : $0[.top]
                    }
            }
            .ignoresSafeArea()
            .animation(.default, value: show)
        }
    }
}

/// 常见UI封装
struct FANText: View {
    let text: String
    var body: some View{
        Text(text)
            .font(.system(size: 20))
            .foregroundColor(.red)
            .lineLimit(1)
    }
}

// 视图一
struct RedView: View {
    var body: some View {
        Rectangle()
            .fill(.red)
            .frame(height: 200)
    }
}

// 视图二
struct GreenView: View {
    var body: some View {
        Rectangle()
            .fill(.green)
            .frame(height: 200)
    }
}
