#include "canteenmenu.h"

CanteenMenu::CanteenMenu(QString name, QString desc, QObject *parent) :
    QObject(parent), mName(name), mDesc(desc)
{
    //this->name = name;
    //this->desc = desc;
}

CanteenMenu::~CanteenMenu()
{

}

void CanteenMenu::setName(QString name)
{
    this->mName = name;
    emit onNameChanged();
}

QString CanteenMenu::getName()
{
    return mName;
}

QString CanteenMenu::getDesc()
{
    return mDesc;
}

void CanteenMenu::setDesc(QString desc)
{
    this->mDesc = desc;
    emit onDescChanged();
}
