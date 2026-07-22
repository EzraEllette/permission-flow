#if os(macOS)
import ApplicationServices
import Foundation

@available(macOS 13.0, *)
public struct AccessibilityPermissionStatusProvider: PermissionStatusProviding {
    public var capability: PermissionStatusCapability { .preflightSupported }
    
    public func authorizationState() -> PermissionAuthorizationState {
        // AccessibilityTrust probes tccd live; bare AXIsProcessTrusted() can
        // read stale-denied until relaunch after an in-flight grant.
        return AccessibilityTrust.isGranted() ? .granted : .notGranted
    }
    
    public init() {}
}
#endif