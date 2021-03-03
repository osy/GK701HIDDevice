# MSI GK-701 Driver for macOS

There is an issue with the MSI GK-701 (and maybe related keyboards) where one key would register as two different keys (for example 'a' => 'am'). This is caused by a bad firmware on the keyboard which intreprets the SET_IDLE USB HID command incorrectly. This causes the keyboard to spew data on the boot protocol interface in addition to the keyboard interface and OSX will see it as two keyboards trying to send input at once.

Long story short, the "fix" is to send SET_IDLE with argument of 0 to put the keyboard into proper operation. This kext will do just that. The only downside is that it requires SIP to be disabled to work. MSI needs to release a firmware update to fix it properly. Additionally, the boot protocol it implements is either broken or unsupported by OSX so you cannot use this keyboard in single user mode or early boot.

## Building (macOS 10.14)

1. You must install Xcode 10.3 because later versions break compatibility with 10.14.
2. Reboot into Recovery OS and run `csrutil enable --without kext`
3. Build with `./package/build.sh`
4. Install the generated .pkg

## Building (macOS 10.15+)

The DriverKit driver requires [entitlements from Apple][1]. You can use the pre-built installer in the releases for a signed and notarized version (no need to disable SIP). Otherwise, we need to [disable SIP][2] and AMFI to use the driver. This applies to both Intel and Apple Silicon.

1. Reboot into Recovery OS and run `csrutil enable --without kext` and `nvram boot-args="$(nvram boot-args) amfi_get_out_of_my_way=1"`
2. Build GK701Installer with Xcode (or `xcodebuild -project GK701HIDDevice.xcodeproj -target GK701Installer`)
3. Copy GK701Installer.app to `/Applications` and launch it.
4. Press "Install"

[1]: https://developer.apple.com/documentation/driverkit/requesting_entitlements_for_driverkit_development
[2]: https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection
