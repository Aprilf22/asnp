# Используем базовый образ AlmaLinux
FROM almalinux:9

# Устанавливаем необходимые пакеты
RUN yum update -y && \
    yum install -y net-snmp net-snmp-utils nginx php-fpm php-cli php-snmp && \
    yum clean all

# Настраиваем SNMP
# RUN systemctl enable snmpd.service
RUN systemctl enable snmptrapd.service

# Настраиваем Nginx
RUN systemctl enable nginx.service

# Настраиваем PHP-FPM
RUN systemctl enable php-fpm.service

# Изменяем конфигурацию PHP-FPM
RUN sed -i 's/^listen = .*/listen = 127.0.0.1:9000/' /etc/php-fpm.d/www.conf

# Изменяем конфигурацию snmptrapd.service
RUN sed -i 's/Environment=OPTIONS="-Lsd"/Environment=OPTIONS="-On"/' /usr/lib/systemd/system/snmptrapd.service


# Настраиваем Nginx
COPY default.conf /etc/nginx/conf.d/default.conf

# Создаем директорию для веб-приложения
RUN mkdir -p /var/www/html && \
    chown -R nginx:nginx /var/www/html

# Создаем директорию для скрипта
#RUN mkdir -p /var/www/html/not

# Копируем PHP-скрипт
#COPY 13.php /var/www/html/not/13.php

# Создаем файл сервиса
 COPY 13.service /etc/systemd/system/13.service

# Включаем и запускаем сервис
RUN systemctl enable 13.service

# Открываем порты
EXPOSE 80
EXPOSE 161
EXPOSE 162

# Запускаем сервисы
CMD ["/usr/sbin/init"]
