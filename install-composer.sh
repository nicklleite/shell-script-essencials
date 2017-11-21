#!/bin/bash

# Rotina para download e instalação do Composer
function installComposer() {
	if [ ! -f /usr/bin/php ]; then
		echo "PHP não instalado! Verifique os pacotes instalados e tente novamente!"
		exit
	else
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

		echo "Executando: sudo mv composer.phar /usr/local/bin/composer"
		sudo mv composer.phar /usr/local/bin/composer
	fi
}

# Execução da rotina principal!
# Here we go...
installComposer