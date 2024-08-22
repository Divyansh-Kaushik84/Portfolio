//
//  ContentView.swift
//  iAmDivyansh
//
//  Created by Divyansh Kaushik on 22/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack(alignment:.leading) {
                Text("Hi")
                Text("I Am Divyansh Kaushik\nA btech 4th year student")
                Image("notFound")
                    .resizable()
                    .frame(
                        height: UIScreen.main.bounds.height/4
                    )
                    .padding(20)
                NavigationLink("NEXT", destination: realShowOfUI())
                    .padding(.leading,150)
                Spacer()
                Text("\"Never judge a book by its cover\"").padding(.leading,50)

            }          
            .padding()
            .navigationTitle("This is my Portfolio")
        }                .navigationBarBackButtonHidden()

    }
}
#Preview {
    ContentView()
}
