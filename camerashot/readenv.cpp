#include "readenv.h"
#include <QDebug>

ReadEnv::ReadEnv(QObject *parent) : QObject(parent)
{
}

QString ReadEnv::getenv(const QString envVarName) const
{
    QByteArray result = qgetenv(envVarName.toStdString().c_str());
    QString output = QString::fromLocal8Bit(result);
    qDebug() << envVarName << " value is: "  << output;
    return output;
}
