#ifndef CANTEENMENU_H
#define CANTEENMENU_H

#include <QObject>

class CanteenMenu : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY onNameChanged)
    Q_PROPERTY(QString desc READ getDesc WRITE setDesc NOTIFY onDescChanged)
public:
    explicit CanteenMenu(QString name, QString desc, QObject *parent = 0);
    //explicit CanteenMenu(QString name, QString desc);
    virtual ~CanteenMenu();

    void setName(QString name);
    QString getName();

    void setDesc(QString desc);
    QString getDesc();

private:
    QString mName;
    QString mDesc;

signals:
    void onNameChanged();
    void onDescChanged();
public slots:

};

#endif // CANTEENMENU_H
