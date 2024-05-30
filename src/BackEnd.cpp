/*
** EPITECH PROJECT, 2024
** QML-Rex
** File description:
** BackEnd.cpp
*/

#include "BackEnd.hpp"

BackEnd::BackEnd(QObject *parent) :
        QObject(parent)
{
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