import Foundation

/*
 Description: Imagin we have a group of intervals, how can we find the maxium number of intervals that does not overlap each other?
 
 The following greedy algorithm does find the optimal solution:

 Select the interval, x, with the earliest finishing time.
 Remove x, and all intervals intersecting x, from the set of candidate intervals.
 Repeat until the set of candidate intervals is empty.
 
 Prove:
 Whenever we select an interval at step 1, we may have to remove many intervals in step 2. However, all these intervals necessarily cross the finishing time of x, and thus they all cross each other (see figure). Hence, at most 1 of these intervals can be in the optimal solution. Hence, for every interval in the optimal solution, there is an interval in the greedy solution. This proves that the greedy algorithm indeed finds an optimal solution.
 
 (in other word, since the chosen interval overlaps with other intervals, and the other intervals overlaps each other, then only one of them can be choosen. Since the interval is sorted by ending time, we should choose the one with earliest ending time so that we can fit more intervals in)
 */

/*
 435. Non-overlapping Intervals
 56. Merge Intervals
 252 Meeting Rooms
 253 Meeting Rooms II
 452 Minimum Number of Arrows to Burst Balloons
 
 */
