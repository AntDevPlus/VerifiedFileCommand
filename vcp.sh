#!/bin/bash
#vcp.sh
#Made by 81AETU
#Version: 2.0
#Rôle: vérifié l'intéfgralité d'une copie faite par cp
#Usage: ./vcp.sh <source> <destination> <R> 
# R si <source> est un répertoire
#Limites connues : fichiers avec des droits de lecture non autorisé dans un répertoire
#Dépendances, prérequis: cp
#2020/05/07
#Numéro de version: 2.0
#Licence: GNU GPL

#Constantes:

CRC32="/usr/bin/crc32"
MD5="/usr/bin/md5sum"
SHA256="/usr/bin/sha256sum"
SHA512="/usr/bin/sha512sum"

HACHFUNCT="/usr/bin/md5sum"

#Fonctions:
Check(){

if [ -e $1 ]
then
    #destiniation est un répertoire
    if [ -d $2 ]  
    then
      sourceprint=$( $HACHFUNCT $1 | cut -d " " -f 1 )
      destprint=$( $HACHFUNCT $2$1 | cut -d " " -f 1 )
    if [ $sourceprint == $destprint ]
    then
      echo "le fichier a été correctement copié"
    else
      echo "erreur"
    exit 1;
    fi

    #destination est un fichier
    else
      sourceprint=$( $HACHFUNCT $1 | cut -d " " -f 1 )
      destprint=$( $HACHFUNCT $2 | cut -d " " -f 1 )

    if [ $sourceprint == $destprint ]
    then
      echo "le fichier a été correctement copié"
    else
      echo "erreur"
    exit 1;
    fi

    fi
else
  echo "Mon fichier source n'existe pas"  
  exit 1
fi

}

#Meme fonction que précédemment mais avec les répertoires
Check_Directory(){

if [ -e $1 ]
then
    #Nous "pesons" les répertoires pour vérifié l'intégralité
    #Puis on réalise un prise d'empreinte
    sourceprint=$( du -k $1 | cut -f1 | $HACHFUNCT | cut -d " " -f 1 )
    destprint=$( du -k $2 | cut -f1 | $HACHFUNCT | cut -d " " -f 1 )
    #détecte si les fichiers sont identiques
    if [ $sourceprint == $destprint ]
    then
      echo "le fichier a été correctement copié"
    else
      echo "erreur"
    exit 1;
    fi
else
  echo "Mon fichier source n'existe pas"  
  exit 1
fi
}

#PROGRAMME
echo "veuillez entrer votre choix de fonction de hachage"
read printchoice

case $printchoice in
"sha256") HACHFUNCT=$SHA256;;
"md5") HACHFUNCT=$MD5;;
"sha512") HACHFUNCT=$SHA512;;
"crc32") HACHFUNCT=$CRC32;;
esac


#args 1 fichier source, args2 fichier destination
if [ $# -lt 2 ]
then
  echo "ce script nécessite deux arguments, ./vcp <fichier source> <fichier destination>"
  exit 1
elif [ $# -eq 2 ]
then
  cp $1 $2 #copie du fichiers
  Check $1 $2
fi

#pour la récursivité 
if [ $# -gt 2 ]
  then
  if [ $3 == "R" ]
  then
    cp -R $1 $2 #copie du repertoire
    Check_Directory $1 $2
  fi
fi