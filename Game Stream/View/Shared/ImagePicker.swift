import SwiftUI
import PhotosUI

public struct ProfileImagePicker: View {
    @Binding private var image: UIImage?
    private var placeholder: Image
    private var title: String
    private var size: CGFloat

    @State private var showingOptions = false
    @State private var showingCamera = false
    @State private var showingGallery = false
    @State private var selectedItem: PhotosPickerItem?

    public init(image: Binding<UIImage?>, placeholder: Image, title: String = "Cambiar foto de perfil", size: CGFloat = 118) {
        self._image = image
        self.placeholder = placeholder
        self.title = title
        self.size = size
    }

    public var body: some View {
        Button {
            showingOptions = true
        } label: {
            ZStack {
                Group {
                    if let uiImage = image {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        placeholder
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .frame(width: size, height: size)
                .clipShape(Circle())

                Image(systemName: "camera")
                    .font(.system(size: 24))
                    .foregroundStyle(.white)
            }
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
        @State private var img: UIImage?
        var body: some View {
            ZStack {
                Color.black.ignoresSafeArea()
                ProfileImagePicker(image: $img, placeholder: Image("perfilEjemplo"))
            }
        }
    }
    return PreviewHost()
}
