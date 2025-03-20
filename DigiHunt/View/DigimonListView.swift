import SwiftUI
import CoreData

struct DigimonListView: View {
    @StateObject var digimonViewModel = DigimonViewModel(
        apiManager: APIServiceManager(),coreDataManager: CoreDataManager())
    @FetchRequest(entity: DigimonEntity.entity(), sortDescriptors: [])
    var resultFromDB: FetchedResults<DigimonEntity>
    var request:NSFetchRequest<DigimonEntity> = DigimonEntity.fetchRequest()
    
    var body: some View {
        TabView {
            NavigationStack {
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.blue.opacity(0.3), Color.cyan.opacity(0.3),
                        ]),
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    VStack {
                        switch digimonViewModel.digimonViewState {
                        case .loading:
                            ProgressView("Loading Digimons...")
                                .frame(width: 200, height: 200)
                                .font(.title2)
                                .foregroundColor(.blue)
                        case .loaded(let digimonList):
                            showDigimonList()
                        case .error(let error):
                            showError(error: error)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .ignoresSafeArea()
                    .searchable(
                        text: $digimonViewModel.searchWord,
                        prompt: "Search Digimon"
                    )
                    .onAppear {
                        digimonViewModel.fetchDigimon()
                        Task{
                            print("Digimon count in Core Data: \(resultFromDB.count)")
                        }
                    }
                    .padding()
                    .navigationTitle("Digimon List")
                }
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            Text("Favorites")
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
            
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
    
//    @ViewBuilder
//    func showDigimonList(digimonList: [Digimon]) -> some View {
//        if digimonList.isEmpty {
//            VStack {
//                Image(systemName: "exclamationmark.triangle.fill")
//                    .font(.largeTitle)
//                    .foregroundColor(.gray)
//                Text("No Digimon Found")
//                    .font(.headline)
//                    .foregroundColor(.gray)
//                    .padding(.top, 5)
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//        } else {
//            List(resultFromDB.map { Digimon(name: $0.name ?? "", img: $0.img ?? "", level: $0.level ?? "") }) { digimon in
//                NavigationLink {
//                    DigimonDetailView(digimon: digimon, digimonViewModel: digimonViewModel)
//                } label: {
//                    DigimonListCell(digimon: digimon)
//                }
//            }
//
//        }
//    }
    
    @ViewBuilder
    func showDigimonList() -> some View {
        if resultFromDB.isEmpty {
            VStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                Text("No Digimon Found")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List(resultFromDB) { digimonEntity in
                NavigationLink {
                    DigimonDetailView(digimon: Digimon(
                        name: digimonEntity.name ?? "Unknown",
                        img: digimonEntity.img ?? "",
                        level: digimonEntity.level ?? "Unknown"
                    ),
                    digimonViewModel: digimonViewModel)
                } label: {
                    DigimonListCell(digimon: Digimon(
                        name: digimonEntity.name ?? "Unknown",
                        img: digimonEntity.img ?? "",
                        level: digimonEntity.level ?? "Unknown"
                    ))
                }
            }
        }
    }

    
    @ViewBuilder
    func showError(error: Error) -> some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("Failed to load Digimon")
                .font(.headline)
                .foregroundColor(.red)
            Text("\(error.localizedDescription)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

#Preview {
    DigimonListView()
}
