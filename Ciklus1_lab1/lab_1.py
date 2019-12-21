#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: EmaPajic
"""

import scipy.signal as sig
import numpy as np
import matplotlib.pyplot as plt

def problem_3(figure_num):
    k = np.linspace(0,100,101)
    x = 100 * np.sin(np.pi*k/2 + np.pi/8)
    b = [1,1]
    a = [4,-2]
    
    y = sig.filtfilt(b,a,x)
    
    plt.figure(figure_num)
    plt.plot(k, x, 'green')
    plt.plot(k, y, 'red')
    plt.title('3. zadatak')
    plt.xlabel('Time [s]')
    plt.ylabel('Signal [a.u.]')
    plt.legend(['Nefiltrirani signal', 'Filtrirani signal'])
    plt.show()

def read_data(txt_file):
    data = []
    file = open(txt_file, 'r')
    temp_line = "something"
    while(temp_line):
        temp_line = file.readline()
        if not temp_line:
            break
        temp_line = temp_line.rstrip()
        temp_line = temp_line.split("\t")
        line = []
        for num in temp_line:
            line.append(float(num))
        data.append(line)
    file.close()
    return np.transpose(data)

def problem_4(figure_num):
    txt_file = "EMG.txt"
    data = read_data(txt_file)
    
    b_butter, a_butter = sig.butter(3, 5/500, 'highpass')
    y_butter = sig.filtfilt(b_butter, a_butter, data[0])
    b_notch, a_notch = sig.iirnotch(50/500, 50/35)
    y = sig.filtfilt(b_notch, a_notch, y_butter)
    
    time = []
    for sample in range(0,77063):
        time.append(sample/1000)
    
    plt.figure(figure_num)
    plt.plot(time, data[0], 'green')
    plt.plot(time, y, 'red')
    plt.legend(['Nefiltrirani signal', 'Filtrirani signal'])
    plt.title('EMG, 4. zadatak')
    plt.xlabel('Time [s]')
    plt.ylabel('EMG signal [V]')
    plt.show()
    
def main():
    
    problem_3(1)
    problem_4(2)
    
if __name__ == "__main__":
    main()