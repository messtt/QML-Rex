#include "backend.h"
#include <iostream>
#include <fstream>
#include <QFile>
#include <QTextStream>
#include <QDebug>

BackEnd::BackEnd(QObject *parent) :
    QObject(parent)
{
    std::cout << "Backend created" << std::endl;
}

Q_INVOKABLE QString BackEnd::readInFile(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Erreur : Impossible d'ouvrir le fichier" << filePath;
        return QString();
    }

    QTextStream in(&file);
    QString firstLine = in.readLine();
    file.close();
    return firstLine;
}

Q_INVOKABLE bool BackEnd::writeToFile(const QString &filePath, const QString &text)
{
    (void)filePath;
    std::string str = "../../save/save.txt";
    std::ofstream fichier(str);
    if (fichier.is_open()) {
        fichier << text.toStdString();
        fichier.close();

        std::cout << "Le texte a été enregistré dans le fichier " << std::endl;
    } else {
        std::cerr << "Erreur: Impossible d'ouvrir le fichier " << std::endl;
    }
    return true;
}

Q_INVOKABLE bool BackEnd::checkCollision(const QString &image1Path, const QPointF &pos1,
QString image2Path, const QPointF &pos2)
{
    std::string cactusPath = image2Path.toStdString();
    cactusPath = cactusPath.erase(0, 4);
    cactusPath = ":" + cactusPath;
    std::cout << "cactusPath: " << cactusPath << std::endl;
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
