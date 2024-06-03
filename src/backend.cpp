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
