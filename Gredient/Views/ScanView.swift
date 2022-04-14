//
//  ScanView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-24.
//

import SwiftUI
import CodeScanner

struct ScanView: View {
    @State private var isShowingScanner = false
    
    var body: some View {
        VStack{
            Button(action:{
                //isShowingScanner = true
                isShowingScanner.toggle()
            }){
                Text("Scan")
            }
        }
        .sheet(isPresented: $isShowingScanner){
            CodeScannerView(codeTypes: [.code128, .code39, .code93, .code39Mod43, .qr, .upce], simulatedData: "Line1 Info\n Line2 Info", completion: handleScan)
        }
    }
    
    
    func handleScan(result: Result<ScanResult, ScanError>){
        switch result{
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            print(details)
        
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
        
        isShowingScanner.toggle()
        isShowingScanner = false
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
