#!/bin/sh


if [ $# == 1 ];then
    echo "Changing directory : $1"
    cd $1
fi

PROJECT_DIR=`pwd`

TEMPLATE_DIR=/home/yasam/projects/tools/eclipse

NAME=`basename $PROJECT_DIR`

echo "Creating project on $PROJECT_DIR"
echo "Project name : $NAME"

echo "Coping project files"

cp $TEMPLATE_DIR/.project ./
cp $TEMPLATE_DIR/.cproject ./

echo "Replacing project name with : $NAME"
cat .project | sed 's/@@__NAME__@@/'$NAME'/g' > .project


