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
class UiAspectRatioConstraint {
    constructor(class_name, size_x_offset, size_x_scale, size_y_offset, size_y_scale, aspect_ratio) {
        this.el = document.querySelector('.' + class_name);
        this.size_x = {
            offset: size_x_offset,
            scale: size_x_scale,
        };
        this.size_y = {
            offset: size_y_offset,
            scale: size_y_scale,
        };
        this.aspect_ratio = aspect_ratio;
    };
// 215, 134
    apply() {
        const offsetHeight = this.el.offsetHeight;
        const offsetWidth = this.el.offsetWidth;

        if (offsetHeight < offsetWidth) {
            this.el.style.height = `calc(${this.size_y.offset}px + ${this.size_y.scale * 100}%)`;
            this.el.style['aspect-ratio'] = `${this.aspect_ratio} / 1`;
        } else {
            this.el.style.width = `calc(${this.size_x.offset}px + ${this.size_x.scale * 100}%)`;
            this.el.style['aspect-ratio'] = `1/ ${this.aspect_ratio}`;
        };

        
        console.log(this.el.offsetWidth, this.el.offsetHeight)
    };
}
