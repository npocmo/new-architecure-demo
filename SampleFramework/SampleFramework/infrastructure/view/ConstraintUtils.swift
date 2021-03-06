import UIKit

infix operator ??? : ComparisonPrecedence
extension Array where Element: Equatable {
    static func ???(lhs: Element, rhs: Array) -> Bool {
        return rhs.contains(lhs)
    }
}

open class ConstraintUtils {
    
    @discardableResult
    static func setToFitSuperView(superView: UIView, view: UIView, topMargin: CGFloat = 0, leftMargin: CGFloat = 0, bottomMargin: CGFloat = 0, rightMargin: CGFloat = 0) -> [NSLayoutConstraint] {
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
   
    @discardableResult
    static func setLeadingAndTrailingToSuperView(superView: UIView, view: UIView, leftMargin: CGFloat = 0, rigthMargin: CGFloat = 0) -> [NSLayoutConstraint] {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            view.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leftMargin),
            view.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -rigthMargin)
        ]
        NSLayoutConstraint.activate(constraints)
        
        return constraints
    }
    
    @discardableResult
    static func setTopToTopOfView(superView: UIView, view: UIView, topMargin: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.topAnchor.constraint(equalTo: superView.topAnchor, constant: topMargin)
        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    static func setTopToBottomOfView(superView: UIView, view: UIView, topMargin: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.topAnchor.constraint(equalTo: superView.bottomAnchor, constant: topMargin)
        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    static func setBottomToBottomOfView(superView: UIView, view: UIView, margin: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -margin)
        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    static func setBottomToTopOfView(superView: UIView, view: UIView, bottomMargin: CGFloat = 0, priority: UILayoutPriority = .defaultHigh) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.bottomAnchor.constraint(equalTo: superView.topAnchor, constant: bottomMargin)
        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    // MARK: - Height
    
    @discardableResult
    static func setHeightEqual(view: UIView, height: CGFloat) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.heightAnchor.constraint(equalToConstant: height)
        constraint.isActive = true
        
        return constraint
    }
    
    // MARK: - Center
    
    @discardableResult
    static func setCenterXToView(superView: UIView, view: UIView) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.centerXAnchor.constraint(equalTo: superView.centerXAnchor)
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    static func setCenterYToView(superView: UIView, view: UIView) -> NSLayoutConstraint {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = view.centerYAnchor.constraint(equalTo: superView.centerYAnchor)
        constraint.isActive = true
        
        return constraint
    }
}
