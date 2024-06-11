#include "backend.h"
#include <iostream>

BackEnd::BackEnd(QObject *parent) :
    QObject(parent)
{
    std::cout << "Backend created" << std::endl;
}

Q_INVOKABLE bool BackEnd::test() {
    std::cout << "function has been call" << std::endl;
    return true;
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
                                         QString image2Path, const QPointF &pos2) {
    std::string cactusPath = image2Path.toStdString();
    cactusPath = cactusPath.erase(0, 4);
    cactusPath = ":" + cactusPath;
    QImage image1(image1Path);
    QImage image2(cactusPath.c_str());
    if (image1.isNull()) {
        std::cout << "ERROR in image2" << std::endl;
        return false;
    }
    if (image2.isNull()) {
        std::cout << "ERROR in image1" << std::endl;
        return false;
    }
    QRect rect1(pos1.toPoint(), image1.size());
    QRect rect2(pos2.toPoint(), image2.size());

    // Intersection des deux rectangles
    QRect intersection = rect1.intersected(rect2);

    // Vérifie s'il y a une intersection
    if (intersection.isEmpty()) {
        return false;
    }

    // Parcourt la zone d'intersection pour vérifier les pixels colorés
    for (int y = intersection.top(); y <= intersection.bottom(); ++y) {
        for (int x = intersection.left(); x <= intersection.right(); ++x) {
            // Convertit les coordonnées en coordonnées locales à chaque image
            QPoint p1 = QPoint(x - pos1.x(), y - pos1.y());
            QPoint p2 = QPoint(x - pos2.x(), y - pos2.y());

            // Vérifie si les pixels sont colorés dans les deux images
            if (image1.valid(p1) && image2.valid(p2) &&
                image1.pixelColor(p1).alpha() > 0 &&
                image2.pixelColor(p2).alpha() > 0) {
                std::cout << "Collision" << std::endl;
                return true;
            }
        }
    }

    // Pas de collision détectée
    return false;
}

