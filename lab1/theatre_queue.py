#! /usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import os
import multiprocessing
import argparse

import numpy as np
import matplotlib.pyplot as plt


plt.rcParams.update({
    "font.serif": ['Times New Roman'],
    "font.sans-serif": ['Arial'],
    "font.family": 'serif',
    # не использовать настройки шрифтов самого matplotlib
    "pgf.rcfonts": False,
    "pgf.texsystem": 'xelatex',
    "xtick.minor.visible": True,
    "ytick.minor.visible": True,
    "axes.grid": True,
    "axes.grid.which": 'both',
    "grid.linewidth": 0.25,
    "grid.linestyle": 'dashed',
    "grid.color": 'gray',
})

# Разбираем аргументы командной строки
parser = argparse.ArgumentParser()
h = "Формат картинки"
parser.add_argument('-f', '--format', type=str, choices=('png', 'pdf', 'pgf'), help=h)
h = "Каталог для сохранения картинок"
parser.add_argument('-d', '--directory', type=str, default='imgs', help=h)

args = parser.parse_args()

# если задан формат картинки, то используем его
FMT = args.format if args.format else 'png'

FOLDER = args.directory + os.sep

fig01 = plt.figure(1, figsize=(8, 3), dpi=300)

ax01 = fig01.add_subplot(1, 1, 1)

label01 = "Количество ожидающих сдачу"

with open('logs/queue.txt', 'r') as f:
    for line in f:
        data = line.split()

        data = list(map(int, data))
        time = range(len(data))

        ax01.plot(time, data, label=label01)



ax01.spines['top'].set_visible(False)
ax01.spines['right'].set_visible(False)
ax01.set_xlabel("Время")
ax01.grid(color='0.5', ls='--', lw=0.5)
ax01.legend(loc='best')

if os.path.exists(FOLDER):
    print(f"{FOLDER} существует")
else:
    print(f"{FOLDER} не существует, создаем")
    os.makedirs(FOLDER)

params = dict(format=FMT, dpi=300, bbox_inches='tight', pad_inches=0.0)
fig01.savefig(f"{FOLDER}time.{FMT}", **params)
