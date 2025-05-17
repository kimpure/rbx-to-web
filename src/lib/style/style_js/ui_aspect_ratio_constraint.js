class UiAspectRatioConstraint {
    constructor(class_name, size_x, size_y, aspect_ratio) {
        this.el = document.querySelector('.' + class_name);
        this.size_x = {
            offset: size_x.offset,
            scale: size_x.scale,
        };
        this.size_y = {
            offset: size_y.offset,
            scale: size_y.scale,
        };
        this.aspect_ratio = aspect_ratio;
    };
    
    apply() {
        const offsetHeight = this.el.offsetHeight;
        const offsetWidth = this.el.offsetWidth;

        if (offsetHeight < offsetWidth) {
            this.el.style.height = `calc(${this.size_y.offset}px + ${this.size_y.scale * 100}%)`;
            this.el.style['aspect-ratio'] = `${this.aspect_ratio} / 1`;
        } else {
            this.el.style.width = `calc(${this.size_x.offset}px + ${this.size_x.scale * 100}%)`;
            this.el.style['aspect-ratio'] = `1 / ${this.aspect_ratio}`;
        };
    };
}
