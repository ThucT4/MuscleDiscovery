import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecuredField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .foregroundColor(Color("Neon"))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecuredField {
                SecureField(text, text: $text)
                    .font(.system(size: 20))
                    .tint(.red)
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
                
            Divider()
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Email", placeholder: "john.doe@hotmail.com")
    }
}
