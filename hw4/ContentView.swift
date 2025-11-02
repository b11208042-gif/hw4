import SwiftUI
import Combine

// MARK: - Model

struct Animal: Identifiable, Equatable {
    let id: UUID
    var name: String
    var latinName: String
    var category: String       // 哺乳類/鳥類/爬蟲類…（簡化）
    var habitat: String
    var diet: String
    var conservationStatus: String   // LC/NT/VU/EN/CR…（簡化用字串）
    var lifespan: String
    var size: String
    var summary: String
    var imageName: String?     // 本地圖片資源名稱，可選
    var isFavorite: Bool       // 之後可在詳情加收藏按鈕用（此版先不露出）
    
    init(id: UUID = UUID(),
         name: String,
         latinName: String,
         category: String,
         habitat: String,
         diet: String,
         conservationStatus: String,
         lifespan: String,
         size: String,
         summary: String,
         imageName: String? = nil,
         isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.latinName = latinName
        self.category = category
        self.habitat = habitat
        self.diet = diet
        self.conservationStatus = conservationStatus
        self.lifespan = lifespan
        self.size = size
        self.summary = summary
        self.imageName = imageName
        self.isFavorite = isFavorite
    }
}

// MARK: - Store (全域資料來源)

final class AnimalStore: ObservableObject {
    @Published var animals: [Animal] = [
        .init(name: "非洲象",
              latinName: "Loxodonta africana",
              category: "哺乳類",
              habitat: "草原、森林",
              diet: "草食",
              conservationStatus: "EN",
              lifespan: "60–70 年",
              size: "2,700–6,000 kg",
              summary: "現存陸地上體型最大的動物之一，具有高度社會性與記憶力。",
              imageName: "elephant"),
        .init(name: "帝王企鵝",
              latinName: "Aptenodytes forsteri",
              category: "鳥類",
              habitat: "南極海岸",
              diet: "肉食（魚、磷蝦）",
              conservationStatus: "NT",
              lifespan: "15–20 年",
              size: "身高約 110–120 cm",
              summary: "企鵝中體型最大者，能在嚴寒環境繁殖並長途覓食。",
              imageName: "penguin"),
        .init(name: "綠蠵龜",
              latinName: "Chelonia mydas",
              category: "爬蟲類",
              habitat: "熱帶、亞熱帶海域",
              diet: "雜食（以海草、藻類為主）",
              conservationStatus: "EN",
              lifespan: "超過 50 年",
              size: "背甲長可達 100–120 cm",
              summary: "重要的海草牧食者，對海洋生態系有關鍵影響。",
              imageName: "seaturtle"),
        .init(name: "小熊貓",
              latinName: "Ailurus fulgens",
              category: "哺乳類",
              habitat: "溫帶山地闊葉林",
              diet: "雜食（以竹為主）",
              conservationStatus: "EN",
              lifespan: "8–10 年（野外）",
              size: "體重 3–6 kg",
              summary: "外型可愛、行動敏捷，善於攀爬，主要分布於喜馬拉雅山脈周邊。",
              imageName: "redpanda"),
        
        .init(name: "灰狼",
              latinName: "Canis lupus",
              category: "哺乳類",
              habitat: "森林、草原、苔原",
              diet: "肉食",
              conservationStatus: "LC",
              lifespan: "6–8 年（野外）",
              size: "體重 25–45 kg（依亞種差異）",
              summary: "具高度社會性與群體狩獵行為，分布廣泛的頂級掠食者。",
              imageName: "wolf"),
        
        .init(name: "北極熊",
              latinName: "Ursus maritimus",
              category: "哺乳類",
              habitat: "北極地區、冰原",
              diet: "肉食（以海豹為主）",
              conservationStatus: "VU",
              lifespan: "20–25 年",
              size: "體重 300–600 kg",
              summary: "北極圈的頂級掠食者，適應寒冷氣候並依賴海冰狩獵。",
              imageName: "polarbear"),
        
        .init(name: "長頸鹿",
              latinName: "Giraffa camelopardalis",
              category: "哺乳類",
              habitat: "非洲稀樹草原",
              diet: "草食（以金合歡樹葉為主）",
              conservationStatus: "VU",
              lifespan: "20–25 年",
              size: "身高 4–5 公尺",
              summary: "陸地上最高的動物，以長頸和斑點花紋聞名。",
              imageName: "giraffe"),
        
        .init(name: "大熊貓",
              latinName: "Ailuropoda melanoleuca",
              category: "哺乳類",
              habitat: "中國中部山區竹林",
              diet: "草食（以竹為主）",
              conservationStatus: "VU",
              lifespan: "20 年（野外）",
              size: "體重 70–120 kg",
              summary: "中國特有物種，以黑白相間毛色和嗜竹習性著稱。",
              imageName: "giantpanda"),
        
        .init(name: "樹懶",
              latinName: "Bradypus variegatus",
              category: "哺乳類",
              habitat: "中南美洲熱帶雨林",
              diet: "草食（樹葉、水果）",
              conservationStatus: "LC",
              lifespan: "20–30 年",
              size: "體重 4–6 kg",
              summary: "以極慢動作與倒掛生活聞名，行動緩慢以節省能量。",
              imageName: "sloth"),
        
        .init(name: "袋鼠",
              latinName: "Macropus rufus",
              category: "哺乳類",
              habitat: "澳洲草原、乾燥地區",
              diet: "草食（草與嫩枝）",
              conservationStatus: "LC",
              lifespan: "10–15 年",
              size: "體重 25–90 kg",
              summary: "澳洲象徵性動物，擁有強壯後肢與育兒袋。",
              imageName: "kangaroo"),
        
        .init(name: "孔雀",
              latinName: "Pavo cristatus",
              category: "鳥類",
              habitat: "印度次大陸森林與農村",
              diet: "雜食（穀物、昆蟲、植物）",
              conservationStatus: "LC",
              lifespan: "15–20 年",
              size: "體長 1–2.3 公尺（含尾羽）",
              summary: "雄鳥以絢麗開屏尾羽求偶，是印度的國鳥。",
              imageName: "peacock"),
        
        .init(name: "貓頭鷹",
              latinName: "Bubo bubo",
              category: "鳥類",
              habitat: "森林、草原、山地",
              diet: "肉食（小型哺乳類、鳥）",
              conservationStatus: "LC",
              lifespan: "20 年（野外）",
              size: "翼展可達 180 公分",
              summary: "夜行猛禽，具有極佳聽覺與夜視能力。",
              imageName: "owl"),
        
        .init(name: "綠鬣蜥",
              latinName: "Iguana iguana",
              category: "爬蟲類",
              habitat: "中南美洲熱帶森林",
              diet: "草食（葉、花、果實）",
              conservationStatus: "LC",
              lifespan: "15–20 年",
              size: "體長 1.5–2 公尺（含尾）",
              summary: "大型樹棲蜥蜴，性情溫和，常作為寵物飼養。",
              imageName: "iguana")
    

    ]
    
    // 以日期決定「今日幸運動物」索引，確保同一天固定
    func luckyIndex(for date: Date = .now) -> Int? {
        guard !animals.isEmpty else { return nil }
        let cal = Calendar.current
        let comps = cal.dateComponents([.year, .month, .day], from: date)
        let seed = (comps.year ?? 0) * 10_000 + (comps.month ?? 0) * 100 + (comps.day ?? 0)
        return abs(seed) % animals.count
    }
}

// MARK: - Root (TabView 三分頁)

struct ContentView: View {
    @StateObject private var store = AnimalStore()
    
    var body: some View {
        TabView {
            NavigationStack {
                LuckyView()
                    .navigationTitle("今日幸運動物")
            }
            .tabItem {
                Label("幸運", systemImage: "sparkles")
            }
            
            NavigationStack {
                BrowseView()
                    .navigationTitle("動物介紹")
            }
            .tabItem {
                Label("介紹", systemImage: "list.bullet")
            }
            
            NavigationStack {
                AddAnimalView()
                    .navigationTitle("新增動物")
            }
            .tabItem {
                Label("新增", systemImage: "plus.app")
            }
        }
        .environmentObject(store)
    }
}

// MARK: - Page 1: 今日幸運動物

struct LuckyView: View {
    @EnvironmentObject private var store: AnimalStore
    @State private var goToDetail = false
    @State private var startIndex: Int = 0
    
    private var luckyAnimal: Animal? {
        guard let idx = store.luckyIndex() else { return nil }
        return store.animals[idx]
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if let lucky = luckyAnimal, let idx = store.luckyIndex() {
                AnimalCard(animal: lucky)
                Button {
                    startIndex = idx
                    goToDetail = true
                } label: {
                    Text("查看詳情")
                        .font(.headline)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(.blue.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.top, 8)
            } else {
                ContentUnavailableView("尚無動物資料", systemImage: "questionmark.folder", description: Text("請先到「新增動物」分頁新增資料。"))
            }
        }
        .padding()
        .navigationDestination(isPresented: $goToDetail) {
            AnimalDetailPagerView(animals: store.animals, startIndex: startIndex)
        }
    }
}

// MARK: - Page 2: 動物介紹（List -> 詳情 Page 水平滑）

struct BrowseView: View {
    @EnvironmentObject private var store: AnimalStore
    @State private var query: String = ""
    
    // 簡單搜尋（名稱/學名/棲地）
    private var filtered: [Animal] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
        if q.isEmpty { return store.animals }
        return store.animals.filter {
            $0.name.localizedCaseInsensitiveContains(q) ||
            $0.latinName.localizedCaseInsensitiveContains(q) ||
            $0.habitat.localizedCaseInsensitiveContains(q)
        }
    }
    
    var body: some View {
        VStack {
            // iOS 17 的 searchable 也可以，但為求兼容，用簡單 TextField
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("搜尋名稱 / 學名 / 棲地", text: $query)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
            .padding(10)
            .background(.gray.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            .padding(.top, 8)
            
            if filtered.isEmpty {
                ContentUnavailableView("找不到符合的動物", systemImage: "binoculars", description: Text("試試其他關鍵字"))
                    .padding(.top, 24)
            } else {
                List {
                    ForEach(filtered.indices, id: \.self) { idx in
                        let animal = filtered[idx]
                        NavigationLink(value: idx) {
                            AnimalRow(animal: animal)
                        }
                    }
                }
                // 把「索引」導到詳情頁；需要把 filtered 的索引換成原始陣列索引
                .navigationDestination(for: Int.self) { filteredIndex in
                    let selected = filtered[filteredIndex]
                    // 在原始 store.animals 找到實際 startIndex
                    if let realIndex = store.animals.firstIndex(of: selected) {
                        AnimalDetailPagerView(animals: store.animals, startIndex: realIndex)
                    } else {
                        // 萬一找不到（理論上不會），就退回整份 filtered 做 pager
                        AnimalDetailPagerView(animals: filtered, startIndex: filteredIndex)
                    }
                }
            }
        }
    }
}

// 單列外觀
struct AnimalRow: View {
    let animal: Animal
    
    var body: some View {
        HStack(spacing: 12) {
            AnimalImage(animal: animal)
                .frame(width: 56, height: 56)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading, spacing: 6) {
                Text(animal.name)
                    .font(.headline)
                Text("\(animal.category) · \(animal.conservationStatus)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

// 卡片外觀（今日幸運用）
struct AnimalCard: View {
    let animal: Animal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AnimalImage(animal: animal)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            Text(animal.name)
                .font(.title2.weight(.semibold))
            Text(animal.summary)
                .foregroundStyle(.secondary)
                .lineLimit(3)
        }
    }
}

// 圖片組件：若找不到本地圖片，退回系統符號
struct AnimalImage: View {
    let animal: Animal
    var body: some View {
        Group {
            if let name = animal.imageName, UIImage(named: name) != nil {
                Image(name)
                    .resizable()
                    .scaledToFill()
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.gray.opacity(0.15))
                    Image(systemName: "photo")
                        .font(.system(size: 28))
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

// MARK: - 詳情頁（水平滑動 page）

struct AnimalDetailPagerView: View {
    let animals: [Animal]
    @State private var index: Int
    
    init(animals: [Animal], startIndex: Int) {
        self.animals = animals
        _index = State(initialValue: max(0, min(startIndex, animals.count - 1)))
    }
    
    var body: some View {
        Group {
            if animals.isEmpty {
                ContentUnavailableView("無資料", systemImage: "tray")
            } else {
                TabView(selection: $index) {
                    ForEach(animals.indices, id: \.self) { i in
                        AnimalDetailPage(animal: animals[i])
                            .tag(i)
                            .padding(.horizontal)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .navigationTitle(animals[index].name)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct AnimalDetailPage: View {
    let animal: Animal
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AnimalImage(animal: animal)
                    .frame(height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                // 基本資訊卡
                VStack(alignment: .leading, spacing: 8) {
                    Text(animal.name)
                        .font(.title2.bold())
                    Text(animal.latinName)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 8) {
                        CapsuleLabel(text: animal.category)
                        CapsuleLabel(text: animal.habitat)
                        CapsuleLabel(text: "保育：\(animal.conservationStatus)")
                    }
                    .padding(.top, 4)
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                // 指標列
                Grid(horizontalSpacing: 12, verticalSpacing: 8) {
                    GridRow {
                        KeyValuePill(key: "食性", value: animal.diet)
                        KeyValuePill(key: "壽命", value: animal.lifespan)
                    }
                    GridRow {
                        KeyValuePill(key: "尺寸", value: animal.size)
                        KeyValuePill(key: "棲地", value: animal.habitat)
                    }
                }
                
                // 摘要
                VStack(alignment: .leading, spacing: 8) {
                    Text("簡介")
                        .font(.headline)
                    Text(animal.summary)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.vertical, 16)
        }
    }
}

struct CapsuleLabel: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(.blue.opacity(0.15))
            .clipShape(Capsule())
    }
}

struct KeyValuePill: View {
    let key: String
    let value: String
    var body: some View {
        HStack {
            Text(key)
                .font(.subheadline.weight(.semibold))
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(.gray.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Page 3: 新增動物（表單）

struct AddAnimalView: View {
    @EnvironmentObject private var store: AnimalStore
    @State private var name = ""
    @State private var latinName = ""
    @State private var category = ""
    @State private var habitat = ""
    @State private var diet = ""
    @State private var status = ""
    @State private var lifespan = ""
    @State private var size = ""
    @State private var summary = ""
    @State private var imageName: String = ""
    
    @State private var showAlert = false
    @State private var alertText = ""
    
    var body: some View {
        Form {
            Section(header: Text("基本資訊")) {
                TextField("名稱（必填）", text: $name)
                TextField("學名", text: $latinName)
                TextField("分類（如：哺乳類）", text: $category)
                TextField("棲地", text: $habitat)
                TextField("食性", text: $diet)
                TextField("保育狀態（如：LC/NT/VU/EN/CR）", text: $status)
            }
            Section(header: Text("補充")) {
                TextField("壽命（如：60–70 年）", text: $lifespan)
                TextField("尺寸（如：體重 25–45 kg）", text: $size)
                TextField("圖片資源名稱（Assets 中檔名）", text: $imageName)
                TextField("簡介", text: $summary, axis: .vertical)
                    .lineLimit(3...6)
            }
            Section {
                Button {
                    addAnimal()
                } label: {
                    HStack {
                        Spacer()
                        Text("新增")
                            .font(.headline)
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .alert(alertText, isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    private func addAnimal() {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            alertText = "請至少填寫名稱"
            showAlert = true
            return
        }
        let new = Animal(
            name: trimmed,
            latinName: latinName,
            category: category,
            habitat: habitat,
            diet: diet,
            conservationStatus: status,
            lifespan: lifespan,
            size: size,
            summary: summary.isEmpty ? "（尚無簡介）" : summary,
            imageName: imageName.isEmpty ? nil : imageName,
            isFavorite: false
        )
        store.animals.insert(new, at: 0)
        alertText = "新增成功！已加入清單頂部。"
        showAlert = true
        
        // 清空表單
        name = ""; latinName = ""; category = ""; habitat = ""
        diet = ""; status = ""; lifespan = ""; size = ""; summary = ""
        imageName = ""
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
