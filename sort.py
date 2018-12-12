import sys

lines = []
while True:
    line = sys.stdin.readline()
    if not line:
        break
    hindex, p, sent = line.strip().split('\t')
    index = int(hindex.split('-')[1])
    lines.append((index, sent))

lines.sort()
for i, sent in lines:
    print(sent)