import SwiftUI

struct ContentView: View {
    var asean: [String] = ["Indonesia", "Singapore", "Malaysia", "Laos", "Philipines", "Cambodia", "Myanmar", "Thailand", "Brunei", "Vietnam"]
    @State var alertShown = false
    @State var correctGuesses: Int = 0
    @State var currentCountry: String = ""
    @State var selectedCountries:[String] = []
    func randomizedCountries(){
        if (selectedCountries.count < 10) {
            var randomCountry = asean.randomElement()!
            while selectedCountries.contains(randomCountry){
                randomCountry = asean.randomElement()!
            }
            currentCountry = randomCountry
            selectedCountries.append(randomCountry)
        }    }
    func countryPressed (number: Int) {
        if asean[number] == currentCountry {
            correctGuesses += 1
        }
        if selectedCountries.count == 10 {
            alertShown = true
        }
        randomizedCountries()
    }

    var body: some View {
        ZStack{
            Color.mint
                .ignoresSafeArea()
            VStack{
                Text("Pilih Bendera dari Negara : ")
                    .foregroundStyle(.black)
                Text(currentCountry)
                    .foregroundStyle(.black)
            }
            
        }.onAppear(){
            randomizedCountries()
        }
        
        HStack{
            Spacer()
            VStack{
                ForEach(0..<5, id: \.self) { number in
                    Button {
                        countryPressed(number: number)
                    } label: {
                        
                        Image(asean[number])
                            .resizable()
                            .frame(width:105,height: 65)
                    }
                }
            }
            Spacer()
            VStack{
                ForEach(5..<10, id: \.self){ number in
                    Button {
                        countryPressed(number: number)
                    } label: {
                        
                        Image(asean[number])
                            .resizable()
                            .frame(width:105,height: 65)
                    }
                    
                }
            }
            Spacer()
        }
        
        .alert("Selamat!", isPresented: $alertShown ){
            Button("Ulangi", role: .cancel) {
               selectedCountries = []
                correctGuesses = 0
                randomizedCountries()
            }
        } message: {
            Text("Kamu berhasil menebak benar \(correctGuesses) dan salah \(10-correctGuesses) dari 10 negara ASEAN")
        }
    }
}

#Preview {
    ContentView()
}
