MOD = 1 << 16

def ones_comp_add16(num1,num2):
    result = num1 + num2
    return result if result < MOD else (result+1) % MOD

n1 = 0b1010001111101001
n2 = 0b1000000110110101
result = ones_comp_add16(n1,n2)

print('''\
  {:016b}
+ {:016b}
------------------
  {:016b}'''.format(n1,n2,result))