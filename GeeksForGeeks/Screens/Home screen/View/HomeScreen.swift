//
//  HomeScreen.swift
//  GeeksForGeeks
//
//  Created by vikash sahu on 12/05/22.
//

import SwiftUI

struct HomeScreen: View {

    @StateObject var viewModel = HomeScreenViewModel()

    var body: some View {
        VStack{
            HeaderView()

            if viewModel.isLoading{
                Spacer()
                ProgressView()
                    .scaleEffect(x: 2, y: 2, anchor: .center)

            }else{
                ScrollView(showsIndicators: false){
                    
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .top)){

                        GeometryReader{reader -> AnyView in

                            DispatchQueue.main.async {
                                if viewModel.startOffset == 0  {
                                    viewModel.startOffset = reader.frame(in: .global).minY
                                }
                                viewModel.offset = reader.frame(in: .global).minY

                                if viewModel.offset - viewModel.startOffset > 100 && !viewModel.started {
                                    viewModel.started = true
                                }
                                if(viewModel.startOffset == viewModel.offset && viewModel.started && !viewModel.released){
                                    withAnimation(Animation.linear){
                                        viewModel.released = true
                                    }
                                    refreshData()
                                }
                            }

                            return AnyView(Color.black.frame(width: 0, height: 0))
                        }
                        

                        if(viewModel.started && viewModel.released){
                            ProgressView()
                                .offset(y:-35)
                        }else{
                            Image(systemName: "arrow.down")
                                .font(.system(size: 16,weight: .heavy))
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: viewModel.started ? 180 :0 ))
                                .offset(y:-25)
                                .animation(.easeIn)
                        }


                        LazyVStack{
                            if(viewModel.firstTopItem != nil){
                                LargeArticleView(item:viewModel.firstTopItem!)
                            }
                            ForEach(viewModel.allRegularItem ,id:\.self){item in
                                RegularArticleView(item:item )
                            }
                        }

                    }.offset(y:viewModel.released ? 40 : -10)
                }
            }
           Spacer()
        }.background(Color(UIColor.systemGray6))
        .onAppear{
            refreshData()
        }.alert(item: $viewModel.alertItem){alertItem in
            Alert(title: alertItem.title,message: alertItem.message,dismissButton: alertItem.dismissButton)
        }
        
    }

    func refreshData(){
        viewModel.getAllNewsFeeds()
    }
}

struct HeaderView: View {
    var body: some View {
        HStack{
            Text("GeeksForGeeks")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.green)
                .padding(.leading,10)
            Spacer()
        }.frame(maxWidth:.infinity)
        .padding(.vertical,10)
        .background(Color.white
                        .shadow(color: .gray, radius:1,x: 0,y:0)
                        .mask(Rectangle().padding(.bottom, -20)))
    }
}


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
