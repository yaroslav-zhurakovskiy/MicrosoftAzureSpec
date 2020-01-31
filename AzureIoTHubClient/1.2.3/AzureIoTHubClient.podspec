Pod::Spec.new do |spec|
    spec.name          = 'AzureIoTHubClient'
    spec.version       = '1.2.3'
    spec.license       = { :type => 'MIT' }
    spec.homepage      = 'https://github.com/tonymillion/Reachability'
    spec.authors       = { 'Microsoft' => '' }
    spec.summary       = 'Azure IoT Hub Client library for CocoaPods.'
    spec.source        = { :git => "https://github.com/Azure/azure-iot-sdk-c.git", :tag => '1.2.3' }
    spec.description = 'This is a CocoaPods release of the Azure C IoT Hub Client.'

    spec.ios.deployment_target  = '8.0'
    spec.watchos.deployment_target  = '6.0'

    spec.prepare_command = "# Keeping this script idempotent makes using it in a\n# development situation much easier.\ngit submodule update --init deps/parson\nrm -R inc > /dev/null 2>&1 || true\nmkdir -p inc\nmkdir -p inc/internal\ncp deps/parson/parson.h inc\ncp iothub_client/inc/internal/*.h inc/internal\ncp iothub_client/inc/*.h inc\ncp serializer/inc/*.h inc\n\n# Assemble the module.modulemap file\npushd inc > /dev/null\necho \"module AzureIoTHubClient [system][extern_c] {\" > module.modulemap\nquote_thing='\"'\nfor filename in *.h; do\n    echo \"    header $quote_thing$filename$quote_thing\" >> module.modulemap\ndone\necho \"    export *\" >> module.modulemap\necho \"}\" >> module.modulemap\npopd > /dev/null\n# Done assembling module.modulemap file"

    spec.preserve_paths = "inc/module.modulemap"
    spec.module_map = "inc/module.modulemap"
    spec.source_files = [
        "inc/*.h",
        "deps/parson/parson.c",
        "iothub_client/src/*.c",
        "serializer/src/*.c"
    ]
    spec.public_header_files = "inc/*.h"
    spec.header_mappings_dir = "inc/"
    spec.user_target_xcconfig = {
        "USE_HEADERMAP": "NO",
        "HEADER_SEARCH_PATHS": "\"${PODS_ROOT}/AzureIoTHubClient/inc/\" \"${PODS_ROOT}/AzureIoTUtility/inc/\" \"${PODS_ROOT}/AzureIoTuMqtt/inc/\" \"${PODS_ROOT}/AzureIoTuAmqp/inc/\"",
        "ALWAYS_SEARCH_USER_PATHS": "NO"
    }
end