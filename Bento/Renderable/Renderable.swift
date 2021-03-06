import UIKit

public protocol Renderable {
    associatedtype View

    var reuseIdentifier: String { get }

    func generate() -> View
    func render(in view: View)
}

public extension Renderable {
    var reuseIdentifier: String {
        return String(reflecting: View.self)
    }
}

public extension Renderable where View: UIView {
    func generate() -> View {
        return View()
    }
}

public extension Renderable where View: UIView & NibLoadable {
    func generate() -> View {
        return View.loadFromNib()
    }
}

public extension Renderable where View: UIView {

    func deletable(
        deleteActionText: String,
        backgroundColor: UIColor? = nil,
        didDelete: @escaping () -> Void
    ) -> AnyRenderable {
        return DeletableComponent(
            source: self,
            deleteActionText: deleteActionText,
            backgroundColor: backgroundColor,
            didDelete: didDelete
        ).asAnyRenderable()
    }

    func on(willDisplayItem: (() -> Void)? = nil, didEndDisplayingItem: (() -> Void)? = nil) -> AnyRenderable {
        return LifecycleComponent(
            source: self,
            willDisplayItem: willDisplayItem,
            didEndDisplayingItem: didEndDisplayingItem
        ).asAnyRenderable()
    }
}
