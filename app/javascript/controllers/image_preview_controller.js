export default class {
  connect() {
    const fileInput = document.querySelector('input[type="file"][multiple]');
    const previewContainer = document.getElementById("image-preview");

    if (fileInput) {
      fileInput.addEventListener("change", () => {
        previewContainer.innerHTML = "";
        Array.from(fileInput.files).forEach((file) => {
          if (file.type.startsWith("image/")) {
            const reader = new FileReader();
            reader.onload = (e) => {
              const img = document.createElement("img");
              img.src = e.target.result;
              img.className =
                "w-full h-32 object-cover rounded-md border border-gray-200 shadow";
              previewContainer.appendChild(img);
            };
            reader.readAsDataURL(file);
          }
        });
      });
    }
  }
}
