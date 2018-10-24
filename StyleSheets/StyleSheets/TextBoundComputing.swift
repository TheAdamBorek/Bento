import UIKit

public protocol TextBoundComputing {
    var textAttributes: [NSAttributedString.Key: Any] { get }
}

extension TextBoundComputing {
    
    public func width(of string: String) -> CGFloat {
        return width(of: string as NSString)
    }
    
    public func width(of string: NSAttributedString) -> CGFloat {
        return width(of: string.string as NSString)
    }
    
    public func width(of string: NSString) -> CGFloat {
        return string
            .size(withAttributes: textAttributes)
            .width
            .rounded(.up)
    }
    
    public func height(of string: String, fittingWidth width: CGFloat) -> CGFloat {
        return height(of: string as NSString, fittingWidth: width)
    }
    
    public func height(of string: NSAttributedString, fittingWidth width: CGFloat) -> CGFloat {
        return height(of: string.string as NSString, fittingWidth: width)
    }
    
    public func height(of string: NSString, fittingWidth width: CGFloat) -> CGFloat {
        return string
            .boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude),
                          options: .usesLineFragmentOrigin,
                          attributes: textAttributes,
                          context: nil)
            .height
            .rounded(.up)
    }
}