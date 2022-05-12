//
//  RegularArticleView.swift
//  GeeksForGeeks
//
//  Created by vikash sahu on 12/05/22.
//

import SwiftUI

struct RegularArticleView: View {
    
    private var url: String
    private var title : String
    private var date : String
    private var time : String
    
    init(item : Item) {
        url = item.thumbnail
        title = item.title
        date = item.pubDate.toDate()?.toString(withFormat: "MMM d") ?? "N/A"
        time =  item.pubDate.toDate()?.toString(withFormat: "hh:mm a") ?? "N/A"
    }
    var body: some View {
        VStack{
               
            HStack(alignment:.center){
     
                    VStack(alignment:.leading){
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.green)
                            .padding(.top)
                           
                        Spacer()
                        
                        HStack{
                            Text(date)
                                .font(.body)
                                .foregroundColor(Color(UIColor.darkGray))
                               
                            Text(time)
                                .font(.body)
                                .foregroundColor(Color.gray)
                                                
                        }
    
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    Spacer()
                   AsyncImage(url: url)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120)
                    .clipped()

                    
                }.frame(height:150)
                .cornerRadius(20)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white).shadow(radius: 1))
                .padding(.horizontal)
                .padding(.bottom)
                 
        }
    }
}

struct RegularArticleView_Previews: PreviewProvider {
    static var previews: some View {
        
        let dummyItem = Item(title: "Congo working to stop new Ebola outbreak in country's east", pubDate: "2022-05-12 08:07:03", link: "https://www.abc.net.au/news/2022-05-12/police-say-1987-murder-of-girl-2-near-oberon-linked-to-nsw-cult/101061396", guid: "https://www.abc.net.au/news/2022-05-12/police-say-1987-murder-of-girl-2-near-oberon-linked-to-nsw-cult/101061396", author: "Jamie McKinnell", thumbnail: "https://live-production.wcms.abc-cdn.net.au/4a3420dc3411cd0081031da2e5a0dffb?impolicy=wcms_crop_resize&amp;cropH=1080&amp;cropW=810&amp;xPos=605&amp;yPos=0&amp;width=862&amp;height=1149", itemDescription: "A woman is extradited to Sydney from New Zealand following a cold case police investigation into the suspected murder of a two-year-old girl 35 years ago.", content: "A woman is extradited to Sydney from New Zealand following a cold case police investigation into the suspected murder of a two-year-old girl 35 years ago.", enclosure: Enclosure(link: "https://live-production.wcms.abc-cdn.net.au/4a3420dc3411cd0081031da2e5a0dffb?impolicy=wcms_crop_resize&amp;cropH=995&amp;cropW=1768&amp;xPos=81&amp;yPos=26&amp;width=862&amp;height=485", type: "image/jpeg", thumbnail: "https://live-production.wcms.abc-cdn.net.au/4a3420dc3411cd0081031da2e5a0dffb?impolicy=wcms_crop_resize&amp;cropH=1080&amp;cropW=810&amp;xPos=605&amp;yPos=0&amp;width=862&amp;height=1149"), categories:[
            "Bushfire",
            "Courts and Trials"
        ] )
        RegularArticleView(item: dummyItem)
            
    }
}
