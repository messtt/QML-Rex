#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>
#include <qqml.h>
#include <QFile>
#include <QTextStream>
#include <QImage>

class BackEnd : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged)
    QML_ELEMENT

public:
    explicit BackEnd(QObject *parent = nullptr);
    Q_INVOKABLE bool writeToFile(const QString &filePath, const QString &text);
    Q_INVOKABLE bool checkCollision(const QString &image1Path, const QPointF &pos1,
                                    const QString &image2Path, const QPointF &pos2);
    QString userName();
    void setUserName(const QString &userName);

signals:
    void userNameChanged();

private:
    QString m_userName;
};

#endif // BACKEND_H
