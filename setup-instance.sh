#!/bin/bash

# Оновлення системи
sudo apt update -y && sudo apt upgrade -y

# Створення користувача adminuser
sudo adduser --disabled-password --gecos "" adminuser
echo "adminuser:SecurePassword123!" | sudo chpasswd

# Додавання adminuser до sudoers
sudo usermod -aG sudo adminuser

# Створення користувача poweruser
sudo adduser --disabled-password --gecos "" poweruser

# Налаштування входу без пароля для poweruser
sudo sed -i 's/^poweruser:x:/poweruser::/' /etc/passwd

# Надання права на виконання iptables для poweruser
echo "poweruser ALL=(ALL) NOPASSWD: /usr/sbin/iptables" | sudo tee -a /etc/sudoers

# Дозвіл тільки poweruser читати домашню директорію adminuser
sudo chmod o-rx /home/adminuser
sudo setfacl -m u:poweruser:r-x /home/adminuser

# Створення символічного посилання до /etc/mtab в домашній директорії poweruser
sudo ln -s /etc/mtab /home/poweruser/mtab_link

# Зміна власника символічного посилання
sudo chown poweruser:poweruser /home/poweruser/mtab_link
