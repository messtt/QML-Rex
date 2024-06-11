#include "backend.h"
#include <iostream>
#include <fstream>

BackEnd::BackEnd(QObject *parent) :
    QObject(parent)
{
    std::cout << "Backend created" << std::endl;
}

Q_INVOKABLE QString BackEnd::readInFile(const QString &filePath)
{
    std::ifstream file(filePath.toStdString());
    std::string firstLine;

    if (file.is_open()) {
        std::getline(file, firstLine);
        file.close();
    } else {
        qDebug() << "Erreur : Impossible d'ouvrir le fichier" << filePath;
        return QString();
    }

    return QString::fromStdString(firstLine);
}

Q_INVOKABLE bool BackEnd::writeToFile(const QString &filePath, const QString &text)
{
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
QString image2Path, const QPointF &pos2)
{
    std::string cactusPath = image2Path.toStdString();
    cactusPath = cactusPath.erase(0, 4);
    cactusPath = ":" + cactusPath;
    QImage image1(image1Path);
    QImage image2(cactusPath.c_str());

    if (image1.isNull() || image2.isNull()) {
        std::cout << "ERROR in image" << std::endl;
        return false;
    }

    QRectF rect1(pos1, QSizeF(image1.width(), image1.height()));
    QRectF rect2(pos2, QSizeF(image2.width(), image2.height()));

    if (rect1.intersects(rect2)) {
        QRectF intersection = rect1.intersected(rect2);
        for (int x = intersection.x(); x < intersection.x() + intersection.width(); ++x) {
            for (int y = intersection.y(); y < intersection.y() + intersection.height(); ++y) {
                if (image1.pixelColor(x - rect1.x(), y - rect1.y()) != QColor(Qt::transparent) &&
                    image1.pixelColor(x - rect1.x(), y - rect1.y()) != QColor(Qt::white) &&
                    image2.pixelColor(x - rect2.x(), y - rect2.y()) != QColor(Qt::transparent) &&
                    image2.pixelColor(x - rect2.x(), y - rect2.y()) != QColor(Qt::white)) {
                    return true;
                }
            }
        }
    }
    return false;
}
