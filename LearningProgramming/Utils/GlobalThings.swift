//
//  GlobalThings.swift
//  LearningProgramming
//
//  Created by Natanael  on 19/11/2021.
//

import Foundation
import SwiftUI

let appName = "Zrozum.IT"
let screenW = UIScreen.main.bounds.width
let screenH = UIScreen.main.bounds.height

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension Color {
    static let ui = Color.UI()
    
    struct UI {
        let darkestBlue = Color("DarkestBlue")
        let darkBlue = Color("DarkBlue")
        let blue = Color("Blue")
        let pastel = Color("Pastel")
        let green = Color("Green")
        
    }
}

struct HiddenNavigationBar : ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
