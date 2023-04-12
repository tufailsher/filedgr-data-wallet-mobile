# FileDGR

| Environment | Android | iOS |
|---|---|---|
| Prod | [![Codemagic Android-Prod build status](https://api.codemagic.io/apps/6422ed8975bc9acc439995f7/android-prod-workflow/status_badge.svg)](https://codemagic.io/apps/6422ed8975bc9acc439995f7/android-prod-worflow/latest_build) | [![Codemagic iOS-Prod build status](https://api.codemagic.io/apps/6422ed8975bc9acc439995f7/ios-prod-workflow/status_badge.svg)](https://codemagic.io/apps/6422ed8975bc9acc439995f7/ios-prod-worflow/latest_build) |
| QA | [![Codemagic Android-QA build status](https://api.codemagic.io/apps/6422ed8975bc9acc439995f7/android-qa-workflow/status_badge.svg)](https://codemagic.io/apps/6422ed8975bc9acc439995f7/android-qa-worflow/latest_build) | [![Codemagic iOS-QA build status](https://api.codemagic.io/apps/6422ed8975bc9acc439995f7/ios-qa-workflow/status_badge.svg)](https://codemagic.io/apps/6422ed8975bc9acc439995f7/ios-qa-worflow/latest_build) |
| Dev | [![Codemagic Android-Dev build status](https://api.codemagic.io/apps/6422ed8975bc9acc439995f7/android-dev-workflow/status_badge.svg)](https://codemagic.io/apps/6422ed8975bc9acc439995f7/android-dev-worflow/latest_build) | [![Codemagic iOS-Dev build status](https://api.codemagic.io/apps/6422ed8975bc9acc439995f7/ios-dev-workflow/status_badge.svg)](https://codemagic.io/apps/6422ed8975bc9acc439995f7/ios-dev-worflow/latest_build) |


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


### Generating the language files

The app uses *.arb* files to provide proper translations for the strings inside it. The project is
built using *(Localizely)[https://localizely.com/]*, so that the translations can be done on their
dashboard and from Android Studio, the developer only needs to sync with whatever is on the web.
Here are the steps you need to follow to be able to sync the language files:

1. Install the *Flutter Intl* plugin on Android Studio.
2. Go to the *My Projects* section from the web dashboard to get the project id and save it somewhere. Then go to your profile and also save the API Token.
3. Click on *Tools > Flutter Intl > Integrate with Localizely > Connect*. Enter the project id and the API Token from the previous step and wait for the process to complete.
4. If you already have some translations in place on the web dashboard, to override the local files click on *Tools > Fluter Intl > Integrate with Localizely > Download ARB Files*.
5. Whenever you add a new translation string, you should add it in the main file (the *intl_en.arb* one) and then use the *Upload main ARB file* to upload the new file to the web dashboard. Afterwards, provide translations on the web and then sync the project language files using the previous step.
6. **Whenever you add a new locale, you must also add a proper entry in the *SupportedLocale* enum from the `local_provider.dart` file!**
