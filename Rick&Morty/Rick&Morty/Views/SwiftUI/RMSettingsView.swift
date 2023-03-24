//
//  RMSettingsView.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 24.03.2023.
//

import SwiftUI

struct RMSettingsView: View {
    let viewModel: RMSettingsViewViewModel
    
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
            List(viewModel.cellViewModels) { viewModel in
                HStack {
                    if let image = viewModel.image {
                        Image(uiImage: image)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .padding(11)
                            .background(Color(viewModel.iconContainerColor))
                            .cornerRadius(6)
                        
                    }
                    Text(viewModel.title)
                        .padding(.leading, 9)
                    Spacer()
                }
                .padding(5)
                .onTapGesture {
                    viewModel.onTapHandler(viewModel.type)
                }
            }
    }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsView(viewModel: RMSettingsViewViewModel.init(cellViewModels: RMSettingsOption.allCases.compactMap({
            return RMSettingsCellViewModel(type: $0) { _ in
                return
            }
        })))
    }
}
