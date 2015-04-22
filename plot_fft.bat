@python -x "%~f0" %* & exit /b
#coding:utf-8
"""plot_fft.py

SPTKのFFT結果をプロットする
http://aidiary.hatenablog.com/entry/20120716/1342414058
"""

import struct
import sys
import numpy as np
import matplotlib.pyplot as plt

if len(sys.argv) != 4:
    print "usage: python plot_fft.py [fft_file] [N] [fs]"
    sys.exit()

fftfile = sys.argv[1]
N = int(sys.argv[2])
fs = int(sys.argv[3])

# FFTファイルをロード
fft = []
f = open(fftfile, "rb")
while True:
    # 4バイト（FLOAT）ずつ読み込む
    b = f.read(4)
    if b == "": break;
    # 読み込んだ4バイトをFLOAT型（f）でアンパック
    val = struct.unpack("f", b)[0]
    fft.append(val)
f.close()

# 横軸（Hz）
freqList = np.fft.fftfreq(N, d=1.0/fs)

# プロット
plt.plot(freqList[:N/2], 20*np.log10(fft[:N/2]))
plt.xlim([0, fs/2])

plt.xlabel("frequency [Hz]")
plt.ylabel("amplitude spectrum")
plt.show()