#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>

#include "readenv.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<ReadEnv>("readenv", 1, 0, "ReadEnv");

    QQuickView view;
    view.setSource(QUrl(QStringLiteral("qrc:///Main.qml")));
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.show();
    return app.exec();
}

