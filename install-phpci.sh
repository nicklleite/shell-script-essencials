#!/bin/bash

# Rotina para instalar o composer
# @see https://getcomposer.org/download/
function installComposer() {
	echo "Executando: cd ~"
	cd ~/

	# Executando comandos para instalação do composer
	echo "Executando: php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\""
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

	echo "Executando: php -r \"if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;\""
	php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

	echo "Executando: php composer-setup.php"
	php composer-setup.php

	echo "Executando: php -r \"unlink('composer-setup.php');\""
	php -r "unlink('composer-setup.php');"

	# Criando link simbólico
	ln -s composer.phar /usr/local/bin/composer
}

# Rotina para baixar o projeto PHPCI e instalar as dependências.
# @see https://www.phptesting.org/install-phpci
function installPhpCi() {
	#Verificando se o composer está instalado
	if [ -f /usr/bin/composer ]; then
		echo "Composer instalado em: /usr/bin/composer"
	elif [ -f /usr/local/bin/composer ]; then
		echo "Composer instalado em: /usr/local/bin/composer"
	else
		echo "Composer não instalado. Executando a instalação..."
		echo "Favor executar o arquivo 'install-phpci.sh' novamente após o término da instalação!"
		installComposer
	fi

	echo "Iniciando a instalação do PHPCI..."

	# Realizando o download do projeto via Composer
	echo "Executando: cd /var/www"
	cd /var/www

	echo "Executando: composer create-project block8/phpci phpci --keep-vcs --no-dev"
	composer create-project block8/phpci phpci --keep-vcs --no-dev

	echo "Executando: cd /var/www/phpci"
	cd /var/www/phpci

	# Realizando a instalação das dependências
	echo "Executando: composer install"
	composer install

	# Realizando a configuração do PHPCI
	echo "Executando: ./console phpci:install"
	./console phpci:install
}

# Execução da rotina principal!
# Here we go...
installPhpCi