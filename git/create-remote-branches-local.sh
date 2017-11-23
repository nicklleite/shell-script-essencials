#!/bin/bash

###############################################################################
#
#	Script para criação de Branches remotas no ambiente local de
#	desenvolvimento
#
#	@author Nicholas Lopes Leite <nicklleite@gmail.com>
#	@date	23/11/2017
#
###############################################################################

git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done