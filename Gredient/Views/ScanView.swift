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
    @State var barcode: [String]
    
    var body: some View {
        CodeScannerView(codeTypes: [.code128, .code39, .qr ,.ean8, .upce, .ean13 ], simulatedData: "Line1 Info \n Line2 Info", completion: handleScan)
            .sheet(isPresented: $isShowingProductView){
                ProductView(scannedCode: $barcode)
            }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>){
        switch result{
        case .success(let result):
            self.barcode = result.string.components(separatedBy: "\n")
        
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
        isShowingProductView.toggle()
    }
}

//struct ScanView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScanView(barcode: ["1234567890123"])
//    }
//}
