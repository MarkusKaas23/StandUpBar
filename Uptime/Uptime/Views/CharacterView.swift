import SwiftUI

// CharacterView draws one of four posture characters using SwiftUI Canvas.
// stage 0 = Cave Dweller (severely hunched)
// stage 1 = Office Slouch (forward head, drooping)
// stage 2 = Upriser (standing tall)
// stage 3 = Posture Champion (victory arms, crown)
struct CharacterView: View {
    let stage: Int

    private let skin   = Color(red: 0.91, green: 0.66, blue: 0.49)
    private let spine  = Color(red: 0.55, green: 0.42, blue: 0.08)
    private let trouser = Color(red: 0.35, green: 0.23, blue: 0.44)
    private let shoe   = Color(red: 0.24, green: 0.16, blue: 0.33)

    var body: some View {
        Canvas { ctx, size in
            switch stage {
            case 0:  drawCaveDweller(ctx, size)
            case 1:  drawSloucher(ctx, size)
            case 2:  drawUpriser(ctx, size)
            default: drawChampion(ctx, size)
            }
        }
    }

    // MARK: Stage 0 – Cave Dweller
    private func drawCaveDweller(_ ctx: GraphicsContext, _ s: CGSize) {
        let w = s.width, h = s.height
        let lw: CGFloat = 2.5

        // Heavily curved spine
        stroke(ctx, color: spine, width: lw + 1) { p in
            p.move(to: .init(x: w*0.50, y: h*0.38))
            p.addCurve(to:        .init(x: w*0.34, y: h*0.80),
                       control1:  .init(x: w*0.40, y: h*0.52),
                       control2:  .init(x: w*0.30, y: h*0.65))
        }
        // Head drooping forward
        fill(ctx, color: skin) { Path(ellipseIn: .init(x: w*0.28, y: h*0.20, width: w*0.30, height: h*0.22)) }
        fill(ctx, color: .black) { Path(ellipseIn: .init(x: w*0.33, y: h*0.28, width: w*0.06, height: h*0.05)) }
        fill(ctx, color: .black) { Path(ellipseIn: .init(x: w*0.48, y: h*0.28, width: w*0.06, height: h*0.05)) }
        stroke(ctx, color: .black, width: 1.5) { p in  // frown
            p.move(to: .init(x: w*0.35, y: h*0.38))
            p.addQuadCurve(to: .init(x: w*0.53, y: h*0.38), control: .init(x: w*0.44, y: h*0.34))
        }
        // Arms dragging toward ground
        stroke(ctx, color: skin, width: lw) { p in
            p.move(to: .init(x: w*0.42, y: h*0.52))
            p.addQuadCurve(to: .init(x: w*0.14, y: h*0.70), control: .init(x: w*0.18, y: h*0.56))
        }
        stroke(ctx, color: skin, width: lw) { p in
            p.move(to: .init(x: w*0.44, y: h*0.54))
            p.addQuadCurve(to: .init(x: w*0.64, y: h*0.68), control: .init(x: w*0.60, y: h*0.56))
        }
        fill(ctx, color: skin) { Path(ellipseIn: .init(x: w*0.07, y: h*0.68, width: w*0.12, height: h*0.07)) }
        fill(ctx, color: skin) { Path(ellipseIn: .init(x: w*0.60, y: h*0.66, width: w*0.12, height: h*0.07)) }
        // Bent legs
        stroke(ctx, color: trouser, width: lw + 0.5) { p in
            p.move(to: .init(x: w*0.36, y: h*0.82))
            p.addQuadCurve(to: .init(x: w*0.22, y: h*0.95), control: .init(x: w*0.22, y: h*0.86))
        }
        stroke(ctx, color: trouser, width: lw + 0.5) { p in
            p.move(to: .init(x: w*0.38, y: h*0.83))
            p.addQuadCurve(to: .init(x: w*0.54, y: h*0.95), control: .init(x: w*0.54, y: h*0.87))
        }
        fill(ctx, color: shoe) { Path(ellipseIn: .init(x: w*0.13, y: h*0.93, width: w*0.18, height: h*0.06)) }
        fill(ctx, color: shoe) { Path(ellipseIn: .init(x: w*0.47, y: h*0.93, width: w*0.18, height: h*0.06)) }
    }

    // MARK: Stage 1 – Office Slouch
    private func drawSloucher(_ ctx: GraphicsContext, _ s: CGSize) {
        let w = s.width, h = s.height
        let lw: CGFloat = 2.5

        stroke(ctx, color: spine, width: lw + 1) { p in
            p.move(to: .init(x: w*0.50, y: h*0.30))
            p.addCurve(to:       .init(x: w*0.44, y: h*0.75),
                       control1: .init(x: w*0.44, y: h*0.46),
                       control2: .init(x: w*0.42, y: h*0.62))
        }
        fill(ctx, color: skin) { Path(ellipseIn: .init(x: w*0.35, y: h*0.08, width: w*0.32, height: h*0.23)) }
        fill(ctx, color: .black) { Path(ellipseIn: .init(x: w*0.40, y: h*0.15, width: w*0.07, height: h*0.06)) }
        fill(ctx, color: .black) { Path(ellipseIn: .init(x: w*0.55, y: h*0.15, width: w*0.07, height: h*0.06)) }
        stroke(ctx, color: .black, width: 1.5) { p in  // neutral line mouth
            p.move(to: .init(x: w*0.42, y: h*0.26))
            p.addLine(to: .init(x: w*0.58, y: h*0.26))
        }
        stroke(ctx, color: skin, width: lw) { p in
            p.move(to: .init(x: w*0.46, y: h*0.42))
            p.addQuadCurve(to: .init(x: w*0.18, y: h*0.62), control: .init(x: w*0.24, y: h*0.48))
        }
        stroke(ctx, color: skin, width: lw) { p in
            p.move(to: .init(x: w*0.48, y: h*0.42))
            p.addQuadCurve(to: .init(x: w*0.80, y: h*0.60), control: .init(x: w*0.74, y: h*0.47))
        }
        fill(ctx, color: skin) { Path(ellipseIn: .init(x: w*0.11, y: h*0.60, width: w*0.12, height: h*0.07)) }
        fill(ctx, color: skin) { Path(ellipseIn: .init(x: w*0.77, y: h*0.58, width: w*0.12, height: h*0.07)) }
        stroke(ctx, color: trouser, width: lw + 0.5) { p in
            p.move(to: .init(x: w*0.44, y: h*0.75))
            p.addQuadCurve(to: .init(x: w*0.30, y: h*0.95), control: .init(x: w*0.30, y: h*0.84))
        }
        stroke(ctx, color: trouser, width: lw + 0.5) { p in
            p.move(to: .init(x: w*0.47, y: h*0.75))
            p.addQuadCurve(to: .init(x: w*0.62, y: h*0.95), control: .init(x: w*0.64, y: h*0.85))
        }
        fill(ctx, color: shoe) { Path(ellipseIn: .init(x: w*0.22, y: h*0.93, width: w*0.18, height: h*0.06)) }
        fill(ctx, color: shoe) { Path(ellipseIn: .init(x: w*0.54, y: h*0.93, width: w*0.18, height: h*0.06)) }
    }

    // MARK: Stage 2 – Upriser
    private func drawUpriser(_ ctx: GraphicsContext, _ s: CGSize) {
        let w = s.width, h = s.height
        let lw: CGFloat = 2.5

        stroke(ctx, color: spine, width: lw + 1) { p in
            p.move(to:   .init(x: w*0.50, y: h*0.27))
            p.addLine(to:.init(x: w*0.50, y: h*0.74))
        }
        fill(ctx, color: skin) { Path(ellipseIn: .init(x: w*0.35, y: h*0.05, width: w*0.32, height: h*0.23)) }
        fill(ctx, color: .black) { Path(ellipseIn: .init(x: w*0.40, y: h*0.11, width: w*0.07, height: h*0.06)) }
        fill(ctx, color: .black) { Path(ellipseIn: .init(x: w*0.55, y: h*0.11, width: w*0.07, height: h*0.06)) }
        stroke(ctx, color: .black, width: 1.5) { p in  // smile
            p.move(to: .init(x: w*0.40, y: h*0.23))
            p.addQuadCurve(to: .init(x: w*0.60, y: h*0.23), control: .init(x: w*0.50, y: h*0.29))
        }
        stroke(ctx, color: skin, width: lw) { p in
            p.move(to: .init(x: w*0.50, y: h*0.40))
            p.addQuadCurve(to: .init(x: w*0.20, y: h*0.62), control: .init(x: w*0.26, y: h*0.46))
        }
        stroke(ctx, color: skin, width: lw) { p in
            p.move(to: .init(x: w*0.50, y: h*0.40))
            p.addQuadCurve(to: .init(x: w*0.80, y: h*0.62), control: .init(x: w*0.74, y: h*0.46))
        }
        fill(ctx, color: skin) { Path(ellipseIn: .init(x: w*0.13, y: h*0.60, width: w*0.12, height: h*0.07)) }
        fill(ctx, color: skin) { Path(ellipseIn: .init(x: w*0.75, y: h*0.60, width: w*0.12, height: h*0.07)) }
        stroke(ctx, color: trouser, width: lw + 0.5) { p in
            p.move(to:   .init(x: w*0.47, y: h*0.74))
            p.addLine(to:.init(x: w*0.36, y: h*0.95))
        }
        stroke(ctx, color: trouser, width: lw + 0.5) { p in
            p.move(to:   .init(x: w*0.53, y: h*0.74))
            p.addLine(to:.init(x: w*0.64, y: h*0.95))
        }
        fill(ctx, color: shoe) { Path(ellipseIn: .init(x: w*0.28, y: h*0.93, width: w*0.18, height: h*0.06)) }
        fill(ctx, color: shoe) { Path(ellipseIn: .init(x: w*0.56, y: h*0.93, width: w*0.18, height: h*0.06)) }
        ctx.draw(Text("✨").font(.system(size: 11)), at: .init(x: w*0.84, y: h*0.10))
    }

    // MARK: Stage 3 – Posture Champion
    private func drawChampion(_ ctx: GraphicsContext, _ s: CGSize) {
        let w = s.width, h = s.height
        let lw: CGFloat = 3.0

        // Perfect spine
        stroke(ctx, color: spine, width: lw + 1) { p in
            p.move(to:   .init(x: w*0.50, y: h*0.24))
            p.addLine(to:.init(x: w*0.50, y: h*0.72))
        }
        // Crown
        fill(ctx, color: .yellow) {
            Path { p in
                p.move(to:   .init(x: w*0.35, y: h*0.10))
                p.addLine(to:.init(x: w*0.38, y: h*0.04))
                p.addLine(to:.init(x: w*0.50, y: h*0.08))
                p.addLine(to:.init(x: w*0.62, y: h*0.04))
                p.addLine(to:.init(x: w*0.65, y: h*0.10))
                p.closeSubpath()
            }
        }
        stroke(ctx, color: Color(red: 0.96, green: 0.62, blue: 0.04), width: 1) { p in
            p.move(to:   .init(x: w*0.35, y: h*0.10))
            p.addLine(to:.init(x: w*0.38, y: h*0.04))
            p.addLine(to:.init(x: w*0.50, y: h*0.08))
            p.addLine(to:.init(x: w*0.62, y: h*0.04))
            p.addLine(to:.init(x: w*0.65, y: h*0.10))
            p.closeSubpath()
        }
        // Head
        fill(ctx, color: skin) { Path(ellipseIn: .init(x: w*0.35, y: h*0.08, width: w*0.32, height: h*0.22)) }
        // Happy eyes (arcs)
        stroke(ctx, color: .black, width: 1.5) { p in
            p.move(to: .init(x: w*0.40, y: h*0.16))
            p.addQuadCurve(to: .init(x: w*0.47, y: h*0.16), control: .init(x: w*0.435, y: h*0.12))
        }
        stroke(ctx, color: .black, width: 1.5) { p in
            p.move(to: .init(x: w*0.54, y: h*0.16))
            p.addQuadCurve(to: .init(x: w*0.61, y: h*0.16), control: .init(x: w*0.575, y: h*0.12))
        }
        // Big smile
        stroke(ctx, color: .black, width: 2) { p in
            p.move(to: .init(x: w*0.38, y: h*0.22))
            p.addQuadCurve(to: .init(x: w*0.62, y: h*0.22), control: .init(x: w*0.50, y: h*0.30))
        }
        // Rosy cheeks
        fill(ctx, color: Color.red.opacity(0.28)) { Path(ellipseIn: .init(x: w*0.34, y: h*0.19, width: w*0.10, height: h*0.06)) }
        fill(ctx, color: Color.red.opacity(0.28)) { Path(ellipseIn: .init(x: w*0.58, y: h*0.19, width: w*0.10, height: h*0.06)) }
        // Victory arms
        stroke(ctx, color: skin, width: lw + 0.5) { p in
            p.move(to: .init(x: w*0.50, y: h*0.37))
            p.addQuadCurve(to: .init(x: w*0.10, y: h*0.14), control: .init(x: w*0.22, y: h*0.26))
        }
        stroke(ctx, color: skin, width: lw + 0.5) { p in
            p.move(to: .init(x: w*0.50, y: h*0.37))
            p.addQuadCurve(to: .init(x: w*0.90, y: h*0.14), control: .init(x: w*0.78, y: h*0.26))
        }
        fill(ctx, color: skin) { Path(ellipseIn: .init(x: w*0.03, y: h*0.08, width: w*0.14, height: h*0.10)) }
        fill(ctx, color: skin) { Path(ellipseIn: .init(x: w*0.83, y: h*0.08, width: w*0.14, height: h*0.10)) }
        // Wide stance
        stroke(ctx, color: trouser, width: lw + 0.5) { p in
            p.move(to:   .init(x: w*0.47, y: h*0.72))
            p.addLine(to:.init(x: w*0.30, y: h*0.95))
        }
        stroke(ctx, color: trouser, width: lw + 0.5) { p in
            p.move(to:   .init(x: w*0.53, y: h*0.72))
            p.addLine(to:.init(x: w*0.70, y: h*0.95))
        }
        fill(ctx, color: shoe) { Path(ellipseIn: .init(x: w*0.20, y: h*0.93, width: w*0.20, height: h*0.07)) }
        fill(ctx, color: shoe) { Path(ellipseIn: .init(x: w*0.60, y: h*0.93, width: w*0.20, height: h*0.07)) }
        // Stars
        ctx.draw(Text("⭐").font(.system(size: 10)), at: .init(x: w*0.08, y: h*0.04))
        ctx.draw(Text("⭐").font(.system(size: 10)), at: .init(x: w*0.92, y: h*0.04))
    }

    // MARK: - Canvas helpers
    private func fill(_ ctx: GraphicsContext, color: Color, path: () -> Path) {
        ctx.fill(path(), with: .color(color))
    }

    private func stroke(_ ctx: GraphicsContext, color: Color, width: CGFloat, path: (inout Path) -> Void) {
        var p = Path()
        path(&p)
        ctx.stroke(p, with: .color(color), lineWidth: width)
    }
}
