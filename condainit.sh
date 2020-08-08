#!/bin/bash

dev_packages="flake8 rope autopep8"
packages="matplotlib numpy pandas scipy scikit-learn joblib"
flake8_ignore="E402, E266, E265"

while getopts 'p:d:' opt
do
  case $opt in
    p)
      packages=$OPTARG;;
    d)
      dev_packages=$OPTARG;;
    esac
done


echo -e "\nSetting up conda environment"
conda install --three

echo -e "\nInstalling ipython kernel"
conda install --dev ipykernel

echo -e "\nInstalling dependencies"
conda install $packages

echo -e "\nInstalling dev dependencies"
conda install --dev $dev_packages


# get name of environment being project name
conda_prettyname="$(basename "$(pwd)")"
conda_name="ipykernel_$conda_prettyname"

echo -e "\nAdding ipython kernel to list of jupyter kernels"
python -m ipykernel install --user --name $conda_name \
--display-name "Python3 ($conda_prettyname)"

echo -e "\nAdding .flake8\n[flake8]\nignore = $flake8_ignore"
echo -e "[flake8]\nignore = $flake8_ignore" > .flake8
