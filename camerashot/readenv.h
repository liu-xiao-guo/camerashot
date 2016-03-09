#ifndef READ_ENV_H
#define READ_ENV_H

#include <QObject>

class ReadEnv : public QObject
{
    Q_OBJECT
public:
    explicit ReadEnv(QObject *parent = 0);
    Q_INVOKABLE QString getenv(const QString envVarName) const;

private:

};

#endif // READ_ENV_H
