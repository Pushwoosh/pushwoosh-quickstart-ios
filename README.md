# Pushwoosh iOS SDK Quick Start Examples

<p align="center">
  <a href="https://docs.pushwoosh.com/developer/pushwoosh-sdk/ios-sdk/"><img src="https://img.shields.io/badge/SDK-Documentation-blue?style=for-the-badge" alt="Documentation"></a>
  <a href="https://github.com/Pushwoosh/pushwoosh-ios-sdk"><img src="https://img.shields.io/badge/iOS_SDK-Repository-green?style=for-the-badge" alt="iOS SDK"></a>
  <a href="https://www.pushwoosh.com"><img src="https://img.shields.io/badge/Pushwoosh-Website-orange?style=for-the-badge" alt="Website"></a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-iOS%2010%2B-lightgrey?style=flat-square" alt="Platform">
  <img src="https://img.shields.io/badge/swift-5.0%2B-orange?style=flat-square" alt="Swift">
  <img src="https://img.shields.io/badge/Xcode-14%2B-blue?style=flat-square" alt="Xcode">
  <img src="https://img.shields.io/badge/license-MIT-green?style=flat-square" alt="License">
</p>

---

A collection of ready-to-run iOS sample projects demonstrating various features of the [Pushwoosh iOS SDK](https://github.com/Pushwoosh/pushwoosh-ios-sdk). Each project is self-contained and can be used as a reference or starting point for your own implementation.

## Table of Contents

- [Requirements](#requirements)
- [Quick Start](#quick-start)
- [Sample Projects](#sample-projects)
  - [Custom Banner](#-custom-banner)
  - [Customizing](#-customizing)
  - [Delivery Tracking](#-delivery-tracking)
  - [Interactive Push](#-interactive-push)
- [Configuration](#configuration)
- [Resources](#resources)
- [Support](#support)
- [License](#license)

## Requirements

| Requirement | Version |
|-------------|---------|
| iOS | 10.0+ |
| Xcode | 14.0+ |
| Swift | 5.0+ |
| Device | Physical device required (push notifications don't work in Simulator) |

## Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/Pushwoosh/pushwoosh-quickstart-ios.git
   cd pushwoosh-quickstart-ios
   ```

2. **Choose a sample project** and open it in Xcode

3. **Configure your credentials** (see [Configuration](#configuration))

4. **Build and run** on a physical device

## Sample Projects

### Custom Banner

> Rich, interactive custom notification banners with stunning visuals

<p align="center">
  <img src="customBanner/Screenshots/ScreenRecording_11-18-20254-39-44PM_1-ezgif.com-video-to-gif-converter-2.gif" width="280" alt="Custom Banner Demo">
</p>

**Features:**
- Full-screen background image with gradient overlay
- Interactive UI with styled action buttons
- Thumbnail support in collapsed notification
- Custom expanded view on long press
- Automatic fallback for failed image loading

**Key Components:**
- Notification Content Extension
- Notification Service Extension
- `PushwooshContentExtensionHelper` for easy integration

[View detailed documentation](customBanner/README.md)

---

### Customizing

> Advanced SDK customization options and configurations

Demonstrates how to customize various aspects of the Pushwoosh SDK behavior:

| Feature | Description |
|---------|-------------|
| **Foreground Alerts** | Control notification display when app is in foreground |
| **Log Level** | Configure SDK logging verbosity |
| **In-App Tracking** | Track user interactions with in-app messages |
| **Geozones** | Location-based push notifications |
| **Rich Media Queue** | Queue multiple Rich Media pages for sequential display |
| **Custom Notification Delegate** | Handle notifications with custom `UNUserNotificationCenterDelegate` |

---

### Delivery Tracking

> Track push notification delivery with Notification Service Extension

**Features:**
- Accurate delivery tracking to Pushwoosh analytics
- Notification Service Extension setup
- Debug instructions for extension testing

**Debugging the Extension:**
1. Run your app on a device
2. Go to **Debug > Attach to Process by PID or Name...**
3. Enter your Notification Service Extension name
4. Send a notification with `"mutable-content": 1`

---

### Interactive Push

> Actionable notifications with custom buttons

**Features:**
- Custom notification actions and categories
- Handle button taps with `UNUserNotificationCenterDelegate`
- Category-based action routing

**Example:**
```swift
func userNotificationCenter(_ center: UNUserNotificationCenter,
                            didReceive response: UNNotificationResponse,
                            withCompletionHandler completionHandler: @escaping () -> Void) {
    let identifier = response.actionIdentifier
    let category = response.notification.request.content.categoryIdentifier

    if category == "YOUR_CATEGORY" {
        switch identifier {
        case "action1":
            // Handle first action
        case "action2":
            // Handle second action
        default:
            break
        }
    }
    completionHandler()
}
```

## Configuration

Each sample project requires minimal configuration:

### 1. Set your Pushwoosh Application Code

In the project's `Info.plist`, update the `Pushwoosh_APPID` key:

```xml
<key>Pushwoosh_APPID</key>
<string>XXXXX-XXXXX</string>
```

Replace `XXXXX-XXXXX` with your Application Code from the [Pushwoosh Control Panel](https://app.pushwoosh.com).

### 2. Update Bundle Identifier

Change the bundle identifier to match your provisioning profile:
1. Select the project in Xcode
2. Go to **Signing & Capabilities**
3. Update **Bundle Identifier**
4. Select your **Team** and signing certificate

### 3. Enable Push Notifications

Ensure your project has the Push Notifications capability:
1. Select your target
2. Go to **Signing & Capabilities**
3. Click **+ Capability**
4. Add **Push Notifications**

## Resources

| Resource | Link |
|----------|------|
| iOS SDK Documentation | [docs.pushwoosh.com](https://docs.pushwoosh.com/developer/pushwoosh-sdk/ios-sdk/) |
| iOS SDK Repository | [github.com/Pushwoosh/pushwoosh-ios-sdk](https://github.com/Pushwoosh/pushwoosh-ios-sdk) |
| API Reference | [pushwoosh.github.io/pushwoosh-ios-sdk](https://pushwoosh.github.io/pushwoosh-ios-sdk/) |
| Sample Application | [github.com/Pushwoosh/pushwoosh-ios-sample](https://github.com/Pushwoosh/pushwoosh-ios-sample) |

## Support

Need help? We're here for you:

- **Documentation**: [docs.pushwoosh.com](https://docs.pushwoosh.com)
- **Community**: [community.pushwoosh.com](https://community.pushwoosh.com)
- **Email**: [support@pushwoosh.com](mailto:support@pushwoosh.com)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Made with ❤️ by <a href="https://www.pushwoosh.com">Pushwoosh</a>
</p>
