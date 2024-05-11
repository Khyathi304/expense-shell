#!/bin/bash


USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2... $R Failure $N"
        exit 1
    else
        echo -e "$2... $G Success $N"
        fi
}
if [ $USERID -ne 0 ]
then
echo "Please run the script with root access"
exit 1
else
echo "You are super User"
fi

dnf module disable nodejs -y &>>$LOGFILE
VALIDATE $? "Disabling default nodejs" 

dnf module enable nodejs:20 -y &>>$LOGFILE
VALIDATE $? "Enabling nodejs 20 Version"

dnf install nodejs -y &>>$LOGFILE
VALIDATE $? "Install  nodejs"

useradd expense &>>$LOGFILE
VALIDATE $? "Adding User "