//
//  ContentView.swift
//  iOS Test
//
//  Created by shereena on 23/12/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    let cellColor : Color = Color(red: 0.17, green: 0.17, blue: 0.17, opacity: 0.80)
    
    var body: some View {
        ZStack {
            Spacer().frame(height: 50)
            List {
                ForEach(viewModel.listDetails.data, id: \.self) { currency in
                    HStack(spacing: 15) {
                        ZStack {
                            Color.white
                                .clipShape(Circle())
                            Text(currency.symbol)
                                .font(.system(size: 10, weight: .heavy))
                                
                        }
                        .frame(width: 50, height: 50)
                        .padding(.leading, 10)
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Name: ")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .light))
                                Text(currency.name)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .medium))
                                Spacer()
                            }
                            HStack {
                                Text("Dollar Rate: ")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .light))
                                Text("\(String(format: "%.02f", currency.quote.usd.price))")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .medium))
                                Spacer()
                            }
                            
                            HStack {
                                Text("Change: ")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .light))
                                Text("\(String(format: "%.02f", currency.quote.usd.percentChange1H)) /hr")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .medium))
                                Spacer()
                            }
                        }
                        Spacer()
                        
                    }
                    .frame(height: 90)
                    .background(cellColor)
//                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.black)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                        .shadow(color: Color.gray, radius: 14))
                }
                Color.clear
                    .frame(width: 0, height: 0, alignment: .bottom)
                    .onAppear {
                        loadMore()
                    }
            }
//            .refreshable {
//                viewModel.getCurrencyDetails(start: 1, end: viewModel.endIndex)
//            }
            .environment(\.defaultMinListRowHeight, 10)
            .frame(height: UIScreen.main.bounds.height * 0.9)
            .listStyle(.plain)
            .listStyle(.sidebar)
            if(viewModel.isLoading) {
                ActivityIndicator()
                    .frame(width: 50, height: 50)
//                    .background(.white)
            }
        }
        .background(Color.black)
        .onAppear() {
            viewModel.getCurrencyDetails(start: 1, end: 20)
        }
        
    }
    
    func loadMore() {
        if let totalCount = viewModel.listDetails.status?.totalCount {
            if(totalCount > viewModel.endIndex) {
                viewModel.endIndex = viewModel.endIndex + 25
            } else {
                viewModel.endIndex = totalCount
            }
            viewModel.getCurrencyDetails(start: 1, end: viewModel.endIndex)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
