# MSI GK-701 Driver for macOS

There is an issue with the MSI GK-701 (and maybe related keyboards) where one key would register as two different keys (for example 'a' => 'am'). This is caused by a bad firmware on the keyboard which intreprets the SET_IDLE USB HID command incorrectly. This causes the keyboard to spew data on the boot protocol interface in addition to the keyboard interface and OSX will see it as two keyboards trying to send input at once.

Long story short, the "fix" is to send SET_IDLE with argument of 0 to put the keyboard into proper operation. This kext will do just that. The only downside is that it requires SIP to be disabled to work. MSI needs to release a firmware update to fix it properly. Additionally, the boot protocol it implements is either broken or unsupported by OSX so you cannot use this keyboard in single user mode or early boot.

## Building (macOS 10.14)

1. You must install Xcode 10.3 because later versions break compatibility with 10.14.
2. Build with `./package/build.sh`
3. Install the generated .pkg

## Building (macOS 10.15+)

The DriverKit driver requires [entitlements from Apple][1]. If you have a developer account and can sign with these entitlements, please open an issue and attach the signed artifacts so everyone else can use it.

To use the DEXT without an Apple developer certificate, you can [disable SIP][2] and add the boot-arg `amfi_get_out_of_my_way=1`. Alternatively, if you do not wish to completely disable your system's security, you can install [AMFIExemption][3].

Once you have either a properly signed build or an AMFI bypass, you can build & run GK701Installer from Xcode and press 'Install' to install the driver.

[1]: https://developer.apple.com/documentation/driverkit/requesting_entitlements_for_driverkit_development
[2]: https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection
[3]: https://github.com/osy86/AMFIExemption
