#!/bin/bash
#vmv.sh
#Made by 81AETU
#Version: 1.0
#Rôle: mv mais avec une vérication
#Usage: ./vmv.sh <source> <destination> <R>
#Dépendances, prérequis: cp
#2020/05/08
#Numéro de version: 1.0
#Licence: GNU GPL

#Fonctions:
removeold(){
  if [ -d $1 ]
  then
  rm -r $1
  else
  rm $1
  fi
}

copyfile(){
  ./vcp.sh $1 $2 > /dev/null
  removeold $1
}

copydir(){
  ./vcp.sh $1 $2 R > /dev/null
  removeold $1
}

if [ $# -eq 2 ]
then
  copyfile $1 $2
elif [ $# -eq 3 ] && [ $3 == "R" ]
then
echo joshua
  copydir $1 $2
fi