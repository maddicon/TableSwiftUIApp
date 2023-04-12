//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Pate, Maddi on 4/12/23.
//

import SwiftUI
import MapKit


let data = [
    Item(name: "El Taco Feliz 2", address: "201 Staples Rd., San Marcos, TX 78666", desc: "Small but amazing taco place. Has more of a Tex-Mex feeling.", lat: 29.864400, long: -97.938000, imageName: "rest1", type: "Mexican", website: "https://www.facebook.com/ElTacoFeliz2/"),
    Item(name: "Cheers Donuts", address: "1300 Texas Hwy 123 #101, San Marcos, TX 78666", desc: "Small family owned donut shop! Great for morning tasty treats.", lat: 29.859350, long: -97.939730, imageName: "rest2", type: "Donuts", website: "https://cheers-donuts.business.site/"),
    Item(name: "Rios Snacks", address: "1122 Texas Hwy 123., San Marcos, TX 78666", desc: "Small Mexican snack spot. Always has the best snacks.", lat: 29.863750, long: -97.939390, imageName: "rest3", type: "Mexican", website: "https://themenustar4.com/webspace/menus.php?code=ordertacosyosoy.com"),
    Item(name: "The Palm Cafe", address: "504 Broadway St., San Marcos, TX 78666", desc: "Delicious food with amazing customer service! They have spectacular breakfast food!", lat: 29.860018, long: -97.940819, imageName: "rest4", type: "Mexican", website: "https://www.facebook.com/oneryalva/"),
    Item(name: "Rosie's Pizza To Go", address: "1318 Texas Hwy 123, San Marcos, TX 78666", desc: "Best to go pizza spot in San Marcos! Always freshly made and ready in no time.", lat: 29.857400, long: -97.939990, imageName: "rest5", type: "Pizza", website: "https://www.rosiespizzatogo.net/")
   
]
    struct Item: Identifiable {
        let id = UUID()
        let name: String
        let address: String
        let desc: String
        let lat: Double
        let long: Double
        let imageName: String
        let type: String
        let website: String
    }


struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.861302, longitude: -97.938995), span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009))

    var body: some View {
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                Map(coordinateRegion: $region, annotationItems: data) { item in
                                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title)
                                        .overlay(
                                            Text(item.name)
                                                .font(.subheadline)
                                                .foregroundColor(.black)
                                                .fixedSize(horizontal: true, vertical: false)
                                                .offset(y: 25)
                                        )
                                }
                            }
                            .frame(height: 300)
                            .padding(.bottom, -30)
                            
                                
            
            }
            .listStyle(PlainListStyle())
            .navigationTitle("San Marcos Restraunts")
        }
    }
}
    
    struct DetailView: View {
        
        @State private var region: MKCoordinateRegion
              
              init(item: Item) {
                  self.item = item
                  _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)))
              }
             
        
        let item: Item
        
        var body: some View {
            VStack {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200)
                Text("Website: \(item.website)")
                    .font(.subheadline)
                Text("Description: \(item.desc)")
                    .font(.subheadline)
                Text("Address: \(item.address)")
                    .font(.subheadline)
            
                    .padding(10)
                Map(coordinateRegion: $region, annotationItems: [item]) { item in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                                .font(.title)
                                .overlay(
                                    Text(item.name)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                        .fixedSize(horizontal: true, vertical: false)
                                        .offset(y: 25)
                                )
                        }
                    }
                        .frame(height: 300)
                        .padding(.bottom, -30)
                      
                          
            }
            .navigationTitle(item.name)
            Spacer()
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

