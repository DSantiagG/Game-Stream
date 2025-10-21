import SwiftUI
import PhotosUI

struct ImagePicker<Label: View>: View {
    
    @Binding private var image: UIImage?
    private let label: Label
    private var title: String

    @State private var showingOptions = false
    @State private var showingCamera = false
    @State private var showingGallery = false
    @State private var selectedItem: PhotosPickerItem?

    public init(image: Binding<UIImage?>, title: String = "Seleccionar imagen", @ViewBuilder label: () -> Label) {
        self._image = image
        self.title = title
        self.label = label()
    }

    public var body: some View {
        Button {
            showingOptions = true
        } label: {
            label
        }
        .confirmationDialog(title, isPresented: $showingOptions, titleVisibility: .visible) {
            Button("Tomar foto") { showingCamera = true }
            Button("Elegir de la galería") { showingGallery = true }
            Button("Cancelar", role: .cancel) {}
        }
        .photosPicker(isPresented: $showingGallery, selection: $selectedItem, matching: .images)
        .fullScreenCover(isPresented: $showingCamera) {
            CameraPicker { uiImage in
                image = uiImage
            }
            .ignoresSafeArea()
        }
        .onChange(of: selectedItem) { _, newItem in
            Task {
                guard let data = try? await newItem?.loadTransferable(type: Data.self),
                      let uiImage = UIImage(data: data) else { return }
                image = uiImage
            }
        }
    }
}

#Preview {
    struct PreviewHost: View {
        @State var profileImage: UIImage?
        
        var body: some View {
            MainLayout{
                ImagePicker(image: $profileImage){
                    ZStack{
                        (profileImage != nil
                            ? Image(uiImage: profileImage!)
                            : Images.Placeholder.profileDefault)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 118, height: 118)
                            .clipShape(Circle())
                        
                        Image(systemName: "camera")
                            .font(.system(size: 24))
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
    return PreviewHost()
}
