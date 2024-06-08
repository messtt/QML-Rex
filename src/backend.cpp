#include "backend.h"
#include <iostream>

BackEnd::BackEnd(QObject *parent) :
    QObject(parent)
{
    std::cout << "Backend created" << std::endl;
}

QString BackEnd::userName()
{
    return m_userName;
}

void BackEnd::setUserName(const QString &userName)
{
    if (userName == m_userName)
        return;

    m_userName = userName;
    emit userNameChanged();
}

Q_INVOKABLE bool BackEnd::writeToFile(const QString &filePath, const QString &text) {
    QFile file(filePath);
    if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        QTextStream out(&file);
        out << text;
        file.close();
        return true;
    }
    return false;
}

Q_INVOKABLE bool BackEnd::checkCollision(const QString &image1Path, const QPointF &pos1,
                                const QString &image2Path, const QPointF &pos2) {
    QImage image1(image1Path);
    QImage image2(image2Path);

    if (image1.isNull() || image2.isNull()) {
        return false;
    }

    QRect rect1(pos1.x(), pos1.y(), image1.width(), image1.height());
    QRect rect2(pos2.x(), pos2.y(), image2.width(), image2.height());

    QRect intersection = rect1.intersected(rect2);

    if (intersection.isEmpty()) {
        return false;
    }

    for (int y = intersection.top(); y <= intersection.bottom(); ++y) {
        for (int x = intersection.left(); x <= intersection.right(); ++x) {
            QPointF p1 = QPointF(x - pos1.x(), y - pos1.y());
            QPointF p2 = QPointF(x - pos2.x(), y - pos2.y());

            if (image1.pixelColor(p1.toPoint()).alpha() > 0 &&
                image2.pixelColor(p2.toPoint()).alpha() > 0) {
                return true;
            }
        }
    }

    return false;
}
