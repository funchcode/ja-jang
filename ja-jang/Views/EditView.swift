//
//  EditView.swift
//  ja-jang
//
//  Created by funch on 2022/03/01.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var startedAt = Date()
    @State private var finishedAt = Date()
    
    func goPrevView() {
        
    }
    
    func delete() {
        
    }
    
    var body: some View {
        ScrollView {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                  Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(20)
                }
                Button(action: goPrevView) {
                    Text("확인")
                }
            }
            HStack {
                Text("3월 1일")
            }
            HStack {
                Text("시작")
                Text("오전")
                Text("03:30")
            }
            DatePicker("날짜를 수정하세요!", selection: $startedAt, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .frame(width: 300, height: 100, alignment: .center)
                .clipped()
            HStack {
                Text("종료")
                Text("오전")
                Text("03:33")
            }
            DatePicker("날짜를 수정하세요!", selection: $finishedAt, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .frame(width: 300, height: 100, alignment: .center)
                .clipped()
            Button(action: delete) {
                Text("삭제")
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}
