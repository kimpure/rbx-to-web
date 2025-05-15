class UiCorner {
    constructor(class_name, offset, scale) {
        this.el = document.querySelector('.' + class_name)
        this.offset = offset;
        this.scale = scale;
    }

    init() {
        this.el.style.borderRadius = `${this.el.offsetHeight * this.scale + this.offset}px`;
    }
}
