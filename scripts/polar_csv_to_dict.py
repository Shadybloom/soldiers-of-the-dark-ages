#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Скрипт преобразует аэродинамические параметры крыла из формата csv в питоновский словарь:
# ./polar_csv_to_dict.py ./polar.csv
# ./polar_csv_to_dict.py ./polar.csv | xclip -i

# Пример поляры:
# http://airfoiltools.com/images/airfoil/goe796-il_l.png
# http://airfoiltools.com/polar/details?polar=xf-goe796-il-1000000-n5
# http://airfoiltools.com/polar/csv?polar=xf-goe796-il-1000000-n5

import os
import sys
import re
import argparse

#-------------------------------------------------------------------------
# Функции:

def create_parser():
    """Список доступных параметров скрипта."""
    parser = argparse.ArgumentParser()
    parser.add_argument('file',
                        nargs='*',
                        help='airfoil polar .cvs'
                        )
    return parser

#-------------------------------------------------------------------------
# Тело программы:

# Создаётся список аргументов скрипта:
parser = create_parser()
namespace = parser.parse_args()

# Проверяем, существует ли указанный файл:
file_patch = ' '.join(namespace.file)
if namespace.file is not None and os.path.exists(file_patch):
    with open(file_patch) as file:
        #Ищем строку в файле
        print("        'Поляра профиля крыла':{")
        for line in file:
            found_head = re.match('^[^-0-9]', line)
            if found_head:
                line = ''.join(re.sub('\n', '', line, 1))
                line = '# ' + line
                line = '            ' + line
                print(line)
            found_line = re.match('^[-0-9]', line)
            if found_line is not None:
                line = ''.join(re.sub('\n', '', line, 1))
                line = ''.join(re.sub(',', ':(', line, 1))
                line = line + '),'
                line = '            ' + line
                print(line)
        print("            },")
else:
    print('Файл не найден:',file_patch)
