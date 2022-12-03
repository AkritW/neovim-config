class Solution:
    def addBinary(self, a: str, b: str) -> str:
        holder = False
        c = ""
        for i in range(max(len(a) + 1, len(b) + 1)):
            j = len(a) - 1 - i
            k = len(b) - 1 - i
            if k < 0 and j < 0 and not holder:
                break
            if k < 0 and j < 0 and holder:
                c = str(1) + c
                holder = False
                break
            if j < 0:
                c = b[k] + c
                break
            if k < 0:
                c = a[j] + c
                break

            if int(a[j]) + int(b[k]) + int(holder) == 3:
                c = str(1) + c
                holder = True
            elif int(a[j]) + int(b[k]) + int(holder) == 2:
                c = str(0) + c
                holder = True
            elif int(a[j]) + int(b[k]) + int(holder) == 1:
                c = str(1) + c
                holder = False
            elif int(a[j]) + int(b[k]) + int(holder) == 0:
                holder = False

        return c


solution = Solution()
print(solution.addBinary("10", "1"))
