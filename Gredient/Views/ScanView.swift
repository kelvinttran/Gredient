//
//  ScanView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-24.
//

import SwiftUI
import CodeScanner


struct ScanView: View {
    @State private var isShowingProductView = false
    
    var body: some View {
        CodeScannerView(codeTypes: [.code128, .code39, .qr ,.ean8, .upce, .ean13 ], simulatedData: "Line1 Info \n Line2 Info", completion: handleScan)
            .sheet(isPresented: $isShowingProductView){
                ProductView()
            }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>){
        switch result{
        case .success(let result):
            let barcode = result.string.components(separatedBy: "\n")
            print(barcode)
        
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
        isShowingProductView.toggle()
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
