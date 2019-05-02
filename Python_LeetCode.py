class Solution:
    #1. Two Sum
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        if len(nums) <= 1:
            return False
        memo = {}
        for i in range(0, len(nums)):
            if target - nums[i] in memo:
                return [memo[target - nums[i]], i]
            memo[nums[i]] = i


    #20. Valid Parentheses
    def isValid(self, s: str) -> bool:
            stack = []
            brackets = {')': '(', '}': '{', ']': '['}
            for char in s:
                if char in brackets.values():
                    stack.append(char)
                elif char in brackets.keys():
                    if len(stack) == 0:
                        return False
                    last = stack.pop()
                    if last != brackets[char]:
                        return False
            return len(stack) == 0

    #46. Permutations
    def permute(self, nums: List[int]) -> List[List[int]]:
        if len(nums) == 0:
            return [[]]
        result = []
        def perm(current,remain):
            if len(remain) == 0:
                result.append(current)
                return
            for i, num in enumerate(remain):
                perm(current + [num], remain[0: i] + remain[i + 1: len(remain)])
        perm([], nums)
        return result

    #53. Maximum Subarray
    def maxSubArray(self, nums: List[int]) -> int:
        # dp: max subarray that ends with nums[i]
        if len(nums) == 0:
            return 0
        dp = [0]*len(nums)
        maxNum = nums[0]
        for i, num in enumerate(nums):
            if i == 0:
                dp[i] = num
            else:
                dp[i] = num + (dp[i - 1] if dp[i - 1] > 0 else 0)
            maxNum = max(maxNum, dp[i])
        return maxNum


