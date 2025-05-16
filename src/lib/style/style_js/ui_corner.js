class UiCorner {
    constructor(class_name, offset, scale) {
        this.el = document.querySelector('.' + class_name);
        this.offset = offset;
        this.scale = scale;
    }

    apply() {
        if (this.el.style.height === '') {
            this.el.style.borderRadius = `${this.el.offsetWidth * this.scale + this.offset}px`;
        } else {
            this.el.style.borderRadius = `${this.el.offsetHeight * this.scale + this.offset}px`;
        }
    }
}
