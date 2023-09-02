#!/usr/bin/env python3

import json
import sys

from scipy.io.wavfile import write
from scipy.interpolate import interp1d

audio_sample_rate = 44100
timescale = 1e-12
audio_length = 0

import numpy as np
from pyDigitalWaveTools.vcd.parser import VcdParser

if len(sys.argv) > 1:
    fname = sys.argv[1]
else:
    print('Give me a vcd file to parse')
    sys.exit(-1)

with open(fname) as vcd_file:
    vcd = VcdParser()
    # parse the data from the testbench dump
    vcd.parse(vcd_file)
    # parse the timescale information from the dump
    # by replacing the units with scientific notation
    timescale = float(vcd.timescale.replace('ps', 'e-12').replace('ns', 'e-9'))
    # access the relevant output signal
    data = vcd.scope.children['tb'].children['uo_out'].data
    # print(data)
    # exit()
    # extract the output values ad corresponding timestamps
    xp = [d[0] * timescale for d in data]
    # shift the signals to the range [-1,1]
    fp = [(1 if d[1]== 'b1' else -1) for d in data]
    # print(xp, fp)
    # exit()
    # create a funciton to perform a zero order hold interpolation
    f = interp1d(xp, fp, kind="zero")
    # interpolate upto the maximum time specified in the dump
    inter = f(np.arange(0, max(xp), 1/audio_sample_rate))
    # print(inter)
    # exit()
    # write the interpolated values to a wav audio file
    write("tone.wav", audio_sample_rate, inter.astype(np.float32))
    exit()


