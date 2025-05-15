function applyUiCornerStyle(class_name, offset, scale) {
    const el = document.querySelector('.' + class_name)
    el.style.borderRadius = `${el.offsetHeight * scale + offset}px`;
}
