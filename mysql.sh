#!/bin/bash


USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2... Failure"
        exit 1
    else
        echo "$2... Success"
        fi
}
if [ $USERID -ne 0 ]
then
echo "Please run the script with root access"
exit 1
else
echo "You are super User"
fi

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "Installing MySql server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enable MySql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Start MySql server"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
VALIDATE $? "Setting up root password"

