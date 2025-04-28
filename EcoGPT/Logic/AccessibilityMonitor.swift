//
//  AccessibilityMonitor.swift
//  AIcology
//
//  Created by Alessio Rubicini on 26/04/25.
//


import Cocoa

class AccessibilityMonitor: NSObject, ObservableObject {
    
    private var observer: AXObserver?
    private var monitoredAppPID: pid_t?
    @Published var lastCapturedText: String?
    
    override init() {
        super.init()
        self.startMonitoring()
        print("Start monitoring accessibility...")
    }

    func startMonitoring() {
        if !checkAccessibilityPermissions() {
            requestAccessibilityPermission()
            return
        } else {
            print("Accessibility permissions are granted.")
        }
        
        NSWorkspace.shared.notificationCenter.addObserver(
            self,
            selector: #selector(focusedAppChanged),
            name: NSWorkspace.didActivateApplicationNotification,
            object: nil
        )
        checkFocusedApp()
    }

    @objc private func focusedAppChanged(notification: Notification) {
        checkFocusedApp()
    }

    private func checkFocusedApp() {
        guard let app = NSWorkspace.shared.frontmostApplication,
              app.localizedName == "ChatGPT" else {
            return
        }
        startObservingTextInput(for: app)
    }

    func startObservingTextInput(for app: NSRunningApplication) {
        let pid = app.processIdentifier
        monitoredAppPID = pid
        
        let appElement = AXUIElementCreateApplication(pid)
        
        var observer: AXObserver?
        let result = AXObserverCreate(pid, { observer, element, notification, refcon in
            let monitor = Unmanaged<AccessibilityMonitor>.fromOpaque(refcon!).takeUnretainedValue()
            monitor.handleAXNotification(element: element, notification: notification)
        }, &observer)

        if result != .success {
            print("Failed to create AXObserver")
            return
        }
        
        self.observer = observer
        
        // Observe when focused element changes (user clicks or moves focus)
        AXObserverAddNotification(observer!, appElement, kAXFocusedUIElementChangedNotification as CFString, UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()))

        AXObserverAddNotification(observer!, appElement, kAXValueChangedNotification as CFString, UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()))
        
        // Add observer to the main run loop
        CFRunLoopAddSource(CFRunLoopGetCurrent(), AXObserverGetRunLoopSource(observer!), .defaultMode)
    
    }

    private func handleAXNotification(element: AXUIElement, notification: CFString) {
        
        if notification as String == kAXFocusedUIElementChangedNotification as String {
            readTextFromFocusedElement(element)
        }
        
        if notification as String == kAXValueChangedNotification as String {
            readTextFromFocusedElement(element)
        }
    }

    private func readTextFromFocusedElement(_ element: AXUIElement) {
        
        // Check if the element has a relevant role
        var role: CFTypeRef?
        let roleResult = AXUIElementCopyAttributeValue(element, kAXRoleAttribute as CFString, &role)
        
        guard roleResult == .success, let roleValue = role as? String else {
            print("Failed to retrieve role.")
            return
        }

        if roleValue == "AXTextField" || roleValue == "AXTextArea" || roleValue == "AXEditableText" {
            
            // Capture the text value
            var value: CFTypeRef?
            let result = AXUIElementCopyAttributeValue(element, kAXValueAttribute as CFString, &value)
            
            if result == .success, let textValue = value as? String {
                //print("Captured text")
                lastCapturedText = textValue
            } else {
                print("Failed to capture text value.")
            }
        } else {
            //print("Element is not a text field or editable text.")
        }
    }

    // MARK: - Accessibility Permissions
    
    // Function to check accessibility permissions
    public func checkAccessibilityPermissions() -> Bool {
        return AXIsProcessTrusted()
    }

    // Function to request accessibility permissions
    private func requestAccessibilityPermission() {
        let alert = NSAlert()
        alert.messageText = "Accessibility Permission Required"
        alert.informativeText = "Please enable Accessibility permissions for this app in System Preferences to monitor other app activities."
        alert.addButton(withTitle: "Open System Preferences")
        alert.addButton(withTitle: "Cancel")
        
        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            // Open the Accessibility settings page in System Preferences
            if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility") {
                NSWorkspace.shared.open(url)
            }
        }
    }
}
