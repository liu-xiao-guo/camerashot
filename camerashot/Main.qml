import QtQuick 2.0
import Ubuntu.Components 1.1
import QtMultimedia 5.0
import readenv 1.0

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    id: root
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "camerashot.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(100)
    height: units.gu(75)

    Page {
        id: mainPage
        title: i18n.tr("camerashot")

        property string path: ""

        ReadEnv {
            id: env
        }

        Item {
            id: page1
            anchors.fill: parent

            Camera {
                id: camera

                imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

                exposure {
                    exposureCompensation: -1.0
                    exposureMode: Camera.ExposurePortrait
                }

                flash.mode: Camera.FlashRedEyeReduction

                imageCapture {
                    onImageCaptured: {
                        photoPreview.source = preview  // Show the preview in an Image
                    }
                }
            }

            VideoOutput {
                id: video
                source: camera
                anchors.fill: parent
                focus : visible // to receive focus and capture key events when visible
                orientation: -90

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        var APP_ID = env.getenv("APP_ID");
                        var app_pkgname = APP_ID.split('_')[0]
                        mainPage.path = env.getenv("XDG_DATA_HOME") +
                                "/" + app_pkgname + "/pic.png";
                        console.log("share path: " + mainPage.path);

                        var a = video.grabToImage(function(result) {
                            result.saveToFile(mainPage.path);
                        }, Qt.size(photoPreview.width, photoPreview.height) );

                        console.log("return result: " + a);

                    }
                }

                Image {
                    id: photoPreview
                }
            }

            Button {
                id: button
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                text: "Show the taken picture"

                onClicked: {
                    pic.visible = true;
                    page1.visible = false;
                    console.log("image path: " + mainPage.path);
                    image.source = "";
                    image.source = "file:///" + mainPage.path;
                }
            }
        }

        Item {
            id: pic

            anchors.fill: parent
            visible: false

            Image {
                id: image
                cache: false
                anchors.fill: parent
            }

            Label {
                text: mainPage.path
            }

            Image {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: units.gu(1)
                anchors.bottomMargin: units.gu(1)
                width: units.gu(3)
                height: units.gu(3)

                source: "images/icon-left-arrow.png"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        pic.visible = false
                        page1.visible = true;
                    }
                }
            }
        }

    }
}

