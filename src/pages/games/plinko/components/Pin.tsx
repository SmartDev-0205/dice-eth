import {Drawable} from "./Drawable";
import Vector2 from "./Vector2";

class Pin extends Drawable {
    public readonly radius: number;
    private readonly color: string;

    constructor(position: Vector2, radius: number, color: string) {
        super(position);
        this.radius = radius;
        this.color = color;
    }

    public draw(ctx: CanvasRenderingContext2D): void {
        ctx.beginPath();
        ctx.arc(this.position.x, this.position.y, this.radius, 0, Math.PI * 2);
        ctx.fillStyle = this.color;
        ctx.fill();
    }
}

export default Pin;
