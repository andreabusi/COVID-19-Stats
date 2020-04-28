//
//  SearchBar.swift
//  COVID-19 Stats
//
//  Created by Busi Andrea on 28/04/2020.
//  Copyright © 2020 BubiDevs. All rights reserved.
//

import SwiftUI


struct SearchBar: UIViewRepresentable {
   
   @Binding var text: String
   var placeholder: String
   
   class Coordinator: NSObject, UISearchBarDelegate {
      
      @Binding var text: String
      
      init(text: Binding<String>) {
         _text = text
      }
      
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         text = searchText
      }
   }
   
   func makeCoordinator() -> SearchBar.Coordinator {
      return Coordinator(text: $text)
   }
   
   func makeUIView(context: Context) -> UISearchBar {
      let searchBar = UISearchBar(frame: .zero)
      searchBar.delegate = context.coordinator
      searchBar.placeholder = placeholder
      searchBar.searchBarStyle = .minimal
      searchBar.autocapitalizationType = .none
      return searchBar
   }
   
   func updateUIView(_ uiView: UISearchBar, context: Context) {
      uiView.text = text
   }
}
