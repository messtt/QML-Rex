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
    QML_ELEMENT

public:
    explicit BackEnd(QObject *parent = nullptr);
    Q_INVOKABLE bool writeToFile(const QString &filePath, const QString &text);
    Q_INVOKABLE QString readInFile(const QString &filePath);
    Q_INVOKABLE bool checkCollision(const QString &image1Path, const QPointF &pos1,
    QString image2Path, const QPointF &pos2);
};

#endif // BACKEND_H
