#使うDockerイメージ
FROM oilrmutp57/mysql5.7:1.0

#ポートを開ける
EXPOSE 3306

RUN sudo touch /tmp/mysql.sock
#MySQL設定ファイルをイメージ内にコピー
ADD ./my.cnf /../mysql/conf.d/my.cnf

#docker runに実行される
CMD ["mysqld"]