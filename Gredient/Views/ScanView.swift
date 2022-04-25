//
//  ScanView.swift
//  Gredient
//
//  Created by Kelvin Tran on 2022-03-24.
//

import SwiftUI
import CodeScanner


struct ScanView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        entity: FMember.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \FMember.firstName, ascending: true),
        ]
    ) var familyMembers: FetchedResults<FMember>
    
    @State private var isShowingProductView = false
    @State var barcode: [String]
    
    var body: some View {
        CodeScannerView(codeTypes: [.code128, .code39, .qr ,.ean8, .upce, .ean13 ], simulatedData: "Line1 Info \n Line2 Info", completion: handleScan)
            .sheet(isPresented: $isShowingProductView, onDismiss: {
//                for famMem in familyMembers{
//                    DataController().setCheck(familyMember: famMem, value: "", context: viewContext)
//                    print("Cleared check.")
//                }
                print("sheet dismissed")
            }){
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
//        let code = ["1234567890123"]
//        ScanView(barcode: .constant(code))
//    }
//}
