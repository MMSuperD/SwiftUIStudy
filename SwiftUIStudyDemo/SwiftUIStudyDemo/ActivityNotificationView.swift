//
//  ActivityNotificationView.swift
//  SwiftUIStudyDemo
//
//  Created by WangDan on 2023/6/7.
//

import SwiftUI

struct ActivityNotificationView: View {
    var body: some View {
        VStack {
            ActivityInfoView().background(Color.green)
            HStack(){
                ProgressView()
                    .frame(height: 40)
                Image("pizza-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20) // 自定义图像大小
                    .offset(y:12)
            }
        }.padding()
        
    }
}

/// 这个是上半部分View
struct ActivityInfoView: View {
    var body: some View {
        HStack (alignment: .top){
            Image("pizza-logo").resizable().frame(width: 60,height: 60,alignment: .leading)
            VStack{
                Group {
                    Text("配送中")
                        .foregroundColor(.white)
                        .bold()
                    Text("您的包裹正在")
                        .foregroundColor(.gray)
                        
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .offset(y:10)
            }
            LogoView().offset(x:-10)
        }
    }
}

///定位图片View
struct LogoView: View {
    var body: some View {
            Image("pizza-logo").resizable()
                .frame(width: 60,height: 30)
                .offset(x:0)
    }
    
}

/// 这个是进度条View
struct ProgressView: View {
    var process: CGFloat = 0.5
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading){
                Group {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 10)
                        .opacity(1)
                        .foregroundColor(Color.gray)
                        .cornerRadius(5)
                    Rectangle()
                        .frame(width: geometry.size.width * 0.5, height: 10)
                        .opacity(1)
                        .overlay(self.gradientColor(geometry: geometry))
                        .cornerRadius(5)
                        .overlay(
                            self.progressImage()
                            .offset(y:-10)
                            ,alignment: .trailing)
                        .overlay(
                            self.progressImage()
                            .offset(y:-10)
                            ,alignment: .leading)
                }.offset(y:30)
            }
        }
       
    }
    
    private func gradientColor(geometry: GeometryProxy) -> some View {
           let startGradient = Color.blue
           let endGradient = Color.green
           let gradient = LinearGradient(gradient: Gradient(colors: [startGradient, endGradient]), startPoint: .leading, endPoint: .trailing)
           return Rectangle().fill(gradient)
       }

       private func progressImage() -> some View {
           let imageName = "pizza-logo" // 替换为您的图像名称
           return Image(imageName)
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 20, height: 20) // 自定义图像大小
               .padding(.trailing, -10) // 自定义图像与进度条的距离
       }
}

struct ActivityNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityNotificationView().background(Color.blue)
    }
}
