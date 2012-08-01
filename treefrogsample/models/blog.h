#ifndef BLOG_H
#define BLOG_H

#include <QStringList>
#include <QDateTime>
#include <QHash>
#include <QSharedDataPointer>
#include <TGlobal>
#include <TAbstractModel>

class TSqlObject;
class BlogObject;


class T_MODEL_EXPORT Blog : public TAbstractModel
{
public:
    Blog();
    Blog(const Blog &other);
    Blog(const BlogObject &object);
    ~Blog();

    int id() const;
    void setId(int id);
    QString title() const;
    void setTitle(const QString &title);
    QString body() const;
    void setBody(const QString &body);
    QString createdAt() const;
    QString updatedAt() const;
    int lockRevision() const;

    static Blog create(int id, const QString &title, const QString &body);
    static Blog create(const QHash<QString, QString> &values);
    static Blog get(int id);
    static Blog get(int id, int lockRevision);
    static QList<Blog> getAll();

private:
    QSharedDataPointer<BlogObject> d;

    TSqlObject *data();
    const TSqlObject *data() const;
};

Q_DECLARE_METATYPE(Blog)
Q_DECLARE_METATYPE(QList<Blog>)

#endif // BLOG_H
