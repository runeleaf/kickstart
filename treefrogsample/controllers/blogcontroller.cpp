#include "blogcontroller.h"
#include "blog.h"


BlogController::BlogController(const BlogController &)
    : ApplicationController()
{ }

void BlogController::index()
{
    QList<Blog> blogList = Blog::getAll();
    texport(blogList);
    render();
}

void BlogController::show(const QString &pk)
{
    Blog blog = Blog::get(pk.toInt());
    texport(blog);
    render();
}

void BlogController::entry()
{
    render();
}

void BlogController::create()
{
    if (httpRequest().method() != Tf::Post) {
        return;
    }
    
    QHash<QString, QString> form = httpRequest().formDataHash("blog");
    Blog blog = Blog::create(form);
    if (!blog.isNull()) {
        QString notice = "Created successfully.";
        tflash(notice);
        redirect(urla("show", blog.id()));
    } else {
        QString error = "Failed to create.";
        texport(error);
        render("entry");
    }
}

void BlogController::edit(const QString &pk)
{
    Blog blog = Blog::get(pk.toInt());
    if (!blog.isNull()) {
        texport(blog);
        session().insert("blog_lockRevision", blog.lockRevision());
        render();
    } else {
        redirect(urla("entry"));
    }
}

void BlogController::save(const QString &pk)
{
    if (httpRequest().method() != Tf::Post) {
        return;
    }

    QString error;
    int rev = session().value("blog_lockRevision").toInt();
    Blog blog = Blog::get(pk.toInt(), rev);
    if (blog.isNull()) {
        error = "Original data not found. It may have been updated/removed by another transaction.";
        tflash(error);
        redirect(urla("edit", pk));
        return;
    } 
    
    QHash<QString, QString> form = httpRequest().formDataHash("blog");
    blog.setProperties(form);
    if (blog.save()) {
        QString notice = "Updated successfully.";
        tflash(notice);
    } else {
        error = "Failed to update.";
        tflash(error);
    }
    redirect(urla("show", pk));
}

void BlogController::remove(const QString &pk)
{
    if (httpRequest().method() != Tf::Post) {
        return;
    }
    
    Blog blog = Blog::get(pk.toInt());
    blog.remove();
    redirect(urla("index"));
}


// Don't remove below this line
T_REGISTER_CONTROLLER(blogcontroller)
