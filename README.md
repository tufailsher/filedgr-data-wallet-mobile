# FileDGR

| Environment | Status |
|---|---|
| Prod | [![Codemagic build status](https://api.codemagic.io/apps/6422ed8975bc9acc439995f7/android-prod-workflow/status_badge.svg)](https://codemagic.io/apps/6422ed8975bc9acc439995f7/android-prod-worflow/latest_build) |
| QA | [![Codemagic build status](https://api.codemagic.io/apps/6422ed8975bc9acc439995f7/android-qa-workflow/status_badge.svg)](https://codemagic.io/apps/6422ed8975bc9acc439995f7/android-qa-worflow/latest_build) |
| Dev | [![Codemagic build status](https://api.codemagic.io/apps/6422ed8975bc9acc439995f7/android-dev-workflow/status_badge.svg)](https://codemagic.io/apps/6422ed8975bc9acc439995f7/android-dev-worflow/latest_build) |


The FileDGR Data Wallet


### Project app structure:

**Language**: Dart <br>
**Architecture**: Provider oriented<br>
**State management**: Provider<br>
**Compiled for**: Android, iOS<br>
**Key-Value Local Files**: Shared Preferences/User Defaults <br>
**Requests**: http <br>
**Crash Logger**: Firebase Crashlytics *(configured individually for both Android and iOS and for each Flavor/Build Configuration)*<br>
**Product Flavors**: dev/qa/prod <br>
**Documentation Generator**: dart doc


### Generate the documentation

The project is fully documented. In order to generate the documentation you only have to run ``dart doc``. The documentation can then be found in *doc > api*. The main file you have to open to see the documentation properly is **index.html**.


### Build flavors

This project is configured with 3 flavors: *dev*, *qa* and *prod*.
You can either run a configuration using the ```flutter run --flavor <flavor_name>``` command, or configure your IDE to do so. In the next few lines I'll describe how to configure Android Studio to run a specific flavor:

1. Click on arrow icon next to *main.dart* found on the top bar. Click on *Edit Configurations*.
2. Add a new *Flutter* configuration.
3. Copy everything from the *main.dart* configuration to the new one.
4. Give the new configuration an appropriate name (e.g.: main-dev).
5. Set the *Build flavor* field to the flavor name you want to run.
6. Press *Apply*.
7. Repeat these steps for the **qa** flavor.
8. Rename the original *main.dart* to *main-prod* and set the flavor name to *prod*.
9. You can now run any of the versions you want.

**Note: Don't run a regular configuration of the *main.dart* file becayse it will result in a build that's not part of any of the flavors configured in this project.**


### Run the tests

The unit tests don't require any configurations. They can be ran as they are.
The integration tests however need a little tweaking. You can either ran them using the following command: ```flutter test --flavor dev integration_test/``` or from the Android Studio IDE, but first you'll have to edit the test(s) configuration by adding the *--flavor dev* as an additional arg.


### Build a release version

For building & running a release version of a flavor you can either add a new configuration with the argument *--release* or run the following command: ```flutter run --release --flavor <flavor_name>```.
