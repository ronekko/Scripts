@python -x "%~f0" %* & exit /b
#coding:utf-8
"""plot_pitch.py

SPTKのpitch結果をプロットする
http://aidiary.hatenablog.com/entry/20120707/1341650415
"""

import struct
import sys
import matplotlib.pyplot as plt

if len(sys.argv) != 2:
    print "usage: python draw_pitch.py [pitch file]"
    sys.exit()
pitch_file = sys.argv[1]

# ピッチファイルをロード
pitch = []
f = open(pitch_file, "rb")
while True:
    # 4バイト（FLOAT）ずつ読み込む
    b = f.read(4)
    if b == "": break;
    # 読み込んだデータをFLOAT型（f）でアンパック
    val = struct.unpack("f", b)[0]
    pitch.append(val)
f.close()

# プロット
plt.plot(range(len(pitch)), pitch)
plt.xlabel("time (frame)")
plt.ylabel("F0 (Hz)")
plt.show()