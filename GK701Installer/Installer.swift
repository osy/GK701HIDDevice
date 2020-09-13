//
// Copyright © 2020 osy86. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SystemExtensions

class Installer: NSObject, OSSystemExtensionRequestDelegate, ObservableObject {
    private let driverID = "com.osy86.GK701HIDDevice"
    @Published var isBusy: Bool = false
    @Published var isInstalled: Bool = false
    @Published var result: String = ""
    
    private func startWork() {
        DispatchQueue.main.async {
            self.isBusy = true
            self.result = "Working..."
        }
    }
    
    func install() {
        let request = OSSystemExtensionRequest.activationRequest(forExtensionWithIdentifier: driverID,
                                                                 queue: DispatchQueue.global(qos: .background))
        request.delegate = self
        let extensionManager = OSSystemExtensionManager.shared
        extensionManager.submitRequest(request)
    }
    
    func uninstall() {
        let request = OSSystemExtensionRequest.deactivationRequest(forExtensionWithIdentifier: driverID,
                                                                   queue: DispatchQueue.global(qos: .background))
        request.delegate = self
        let extensionManager = OSSystemExtensionManager.shared
        extensionManager.submitRequest(request)
    }
    
    func request(_ request: OSSystemExtensionRequest, actionForReplacingExtension existing: OSSystemExtensionProperties, withExtension ext: OSSystemExtensionProperties) -> OSSystemExtensionRequest.ReplacementAction {
        return .replace
    }
    
    func requestNeedsUserApproval(_ request: OSSystemExtensionRequest) {
        DispatchQueue.main.async {
            self.result = "You must approve the installation request in: System Preferences -> Security & Privacy."
        }
    }
    
    func request(_ request: OSSystemExtensionRequest, didFinishWithResult result: OSSystemExtensionRequest.Result) {
        DispatchQueue.main.async {
            self.isBusy = false
            switch result {
            case .completed: self.result = "Completed successfully."
            case .willCompleteAfterReboot: self.result = "You must restart your computer to complete the request."
            @unknown default:
                self.result = "Unknown result."
            }
        }
    }
    
    func request(_ request: OSSystemExtensionRequest, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.isBusy = false
            self.result = error.localizedDescription
        }
    }
}
