import UIKit

infix operator ??? : ComparisonPrecedence
extension Array where Element: Equatable {
    public static func ???(lhs: Element, rhs: Array) -> Bool {
        return rhs.contains(lhs)
    }
}

open class ConstraintUtils {
    
    // MARK: - Fit Other View
    
    @discardableResult
    public static func setToFitSuperView(superView: UIView, view: UIView, topMargin: CGFloat = 0, leftMargin: CGFloat = 0, bottomMargin: CGFloat = 0, rightMargin: CGFloat = 0) -> [NSLayoutConstraint] {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            view.topAnchor.constraint(equalTo: superView.topAnchor, constant: topMargin),
            view.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottomMargin),
            view.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leftMargin),
            view.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -rightMargin)
        ]
        NSLayoutConstraint.activate(constraints)
        
        return constraints
    }
    
    public static func setToTopOfViewControllerInsideSafeArea(viewController: UIViewController,
                                                              view: UIView,
                                                              topMargin: CGFloat = 0,
                                                              leftMargin: CGFloat = 0,
                                                              rightMargin: CGFloat = 0) {
        let superView = viewController.view!
        let margins = superView.layoutMarginsGuide
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: leftMargin),
            view.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -rightMargin)
        ])
        
        let anchor = superView.safeAreaLayoutGuide.topAnchor
        let topConstraint = superView.constraints.filter {
            let anchors = [$0.firstAnchor, $0.secondAnchor]
            let views = [$0.firstItem as? UIView, $0.secondItem as? UIView]
            return anchor ??? anchors && view ??? views
        }.first
        if let topConstraint = topConstraint {
            topConstraint.constant = topMargin
        } else {
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: anchor, constant: topMargin)
            ])
        }
    }
    
    @discardableResult
    public static func setToTopOfSuperView(superView: UIView,
                                           view: UIView,
                                           topMargin: CGFloat = 0,
                                           leftMargin: CGFloat = 0,
                                           rightMargin: CGFloat = 0) -> [NSLayoutConstraint] {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            view.topAnchor.constraint(equalTo: superView.topAnchor, constant: topMargin),
            view.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leftMargin),
            view.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -rightMargin)
        ]
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    public static func setToBottomOfSuperView(superView: UIView, view: UIView, bottomMargin: CGFloat = 0, leftMargin: CGFloat = 0, rigthMargin: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        superView.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1, constant: -bottomMargin))
        superView.addConstraint(NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: superView, attribute: .left, multiplier: 1, constant: leftMargin))
        superView.addConstraint(NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: superView, attribute: .right, multiplier: 1, constant: -rigthMargin))
    }
    
    @discardableResult
    public static func setLeadingToSuperView(superView: UIView, view: UIView, leftMargin: CGFloat = 0) -> [NSLayoutConstraint] {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            view.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leftMargin)
        ]
        NSLayoutConstraint.activate(constraints)
        
        return constraints
    }
    
    @discardableResult
    public static func setTrailing(of firstView: UIView, to secondView: UIView, rightMargin: CGFloat = 0) -> NSLayoutConstraint {
        firstView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = firstView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -rightMargin)
        NSLayoutConstraint.activate([constraint])
        
        return constraint
    }
    
    @discardableResult
    public static func setLeadingAndTrailingToSuperView(superView: UIView, view: UIView, leftMargin: CGFloat = 0, rigthMargin: CGFloat = 0) -> [NSLayoutConstraint] {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            view.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leftMargin),
            view.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -rigthMargin)
        ]
        NSLayoutConstraint.activate(constraints)
        
        return constraints
    }
    
    // MARK: - Top
    
    @discardableResult
    public static func setTopToTopOfView(superView: UIView, view: UIView, topMargin: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.topAnchor.constraint(equalTo: superView.topAnchor, constant: topMargin)
        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    public static func setTopToSafeAreaTop(superView: UIView, view: UIView, margin: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        var constraint: NSLayoutConstraint
        constraint = view.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: margin)
        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    public static func setTopToBottomOfView(superView: UIView, view: UIView, topMargin: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.topAnchor.constraint(equalTo: superView.bottomAnchor, constant: topMargin)
        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    // MARK: - Bottom
    
    @discardableResult
    public static func setBottomToBottomOfView(superView: UIView, view: UIView, margin: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -margin)
        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    public static func setBottomToTopOfView(superView: UIView, view: UIView, bottomMargin: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.bottomAnchor.constraint(equalTo: superView.topAnchor, constant: bottomMargin)
        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    public static func setBottomToSafeAreaBottom(superView: UIView, view: UIView, margin: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        var constraint: NSLayoutConstraint
        constraint = view.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: -margin)
        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    // MARK: - Height
    
    @discardableResult
    public static func setHeightEqual(view: UIView, height: CGFloat) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.heightAnchor.constraint(equalToConstant: height)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    public static func setHeightGreaterThanOrEqual(view: UIView, height: CGFloat) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.heightAnchor.constraint(greaterThanOrEqualToConstant: height)
        constraint.isActive = true
        
        return constraint
    }
    
    // MARK: - Width
    
    @discardableResult
    public static func setWidth(view: UIView, width: CGFloat) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.widthAnchor.constraint(equalToConstant: width)
        constraint.isActive = true
        
        return constraint
    }
    
    // MARK: - Center
    
    @discardableResult
    public static func setCenterXToView(superView: UIView, view: UIView) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.centerXAnchor.constraint(equalTo: superView.centerXAnchor)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    public static func setCenterYToView(superView: UIView, view: UIView) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.centerYAnchor.constraint(equalTo: superView.centerYAnchor)
        constraint.isActive = true
        
        return constraint
    }
    
    public static func setToCenterOf(superView: UIView, view: UIView, width: CGFloat, height: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        superView.addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: superView, attribute: .centerX, multiplier: 1, constant: 0))
        superView.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: superView, attribute: .centerY, multiplier: 1, constant: 0))
        superView.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width))
        superView.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height))
    }
    
    // MARK: - Helper
    
    public static func switchConstraints(onOff: Bool = true, on: NSLayoutConstraint, off: NSLayoutConstraint) {
        off.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(onOff ? 100 : 999))
        on.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(onOff ? 999 : 100))
    }
    
    public static func turnConstraint(on: Bool, constraint: NSLayoutConstraint) {
        constraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(on ? 999 : 100))
    }
    
    // MARK: - Leading
    
    @discardableResult
    public static func setLeadingToSuperView(superView: UIView, view: UIView, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            view.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: margin)
        ]
        NSLayoutConstraint.activate(constraints)
        
        return constraints
    }
    
    // MARK: - Trailing
    
    @discardableResult
    public static func setTrailingToSuperView(superView: UIView, view: UIView, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            view.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -margin)
        ]
        NSLayoutConstraint.activate(constraints)
        
        return constraints
    }
}
