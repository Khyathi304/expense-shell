#!/bin/bash


USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "Please enter DB password:"
read -s mysql_root_password
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

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "Installing MySql server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enable MySql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Start MySql server"

#mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
#VALIDATE $? "Setting up root password"

mysql -h db.daws304.online -uroot -p${mysql_root_password} -e 'SHOW DATABASES;' &>>$LOGFILE
if [ $? -ne 0 ]
then
mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
VALIDATE $? "mysql is installing::"
else
echo -e "mysql is already installed please skip.. $Y SKIPPING $N"
fi

