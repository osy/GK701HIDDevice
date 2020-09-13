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

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var installer: Installer
    
    var body: some View {
        VStack {
            Spacer()
            Text("Keyboard Driver for MSI GK-701")
                .font(.title)
            HStack {
                Spacer()
                Button(action: {
                    self.installer.install()
                }, label: {
                    Text("Install")
                })
                Button(action: {
                    self.installer.uninstall()
                }, label: {
                    Text("Uninstall")
                })
                Spacer()
            }.disabled(installer.isBusy)
            Text(installer.result)
            Spacer()
        }.padding()
        .frame(width: 500, height: 300)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
