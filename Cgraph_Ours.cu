#include <iostream>

// #define n 13
// #define m 23
using namespace std;
#include <vector>
#include <algorithm>


__global__ void dummyKernel() {
    // Placeholder kernel
}

int main() {
    int n=13;
    int m=23;

    // Example initialization (optional)
    int ver[n]={0,5,8,8,9,9,10,14,15,18,19,21,23};
    int edges[m]={1,5,8,3,7,9,5,10,6,0,0,4,8,5,5,2,4,11,5,2,8,5,2};
    int weight[m]={2,4,9,1,8,1,2,5,2,4,3,5,2,4,3,1,2,4,1,6,1};

    bfs(ver, edges, 1); // Call BFS with the first vertex as source

    std::vector<int> sink(n, 0); // Initialize all elements to 0

    sink.clear(); // Clear the vector to ensure it's empty before pushing back
    for (int i = 0; i < n - 1; i++) {
        if (ver[i] == ver[i + 1]) {
            sink.push_back(i);
        }
    }


    int count[m] = {0}; // Initialize all elements to 0
    for (int i = 0; i < m; i++) {
        count[edges[i]]++;
    }

    for (size_t i = 0; i < sink.size(); i++) {
        int sinkIndex = sink[i];
        if (sinkIndex >= 0 && sinkIndex < n) {
            for (int j = sinkIndex; j < m - 1; j++) {
                count[j] = count[j + 1]; // Shift elements to the left
            }
            count[m - 1] = 0; // Set the last element to 0 after shifting
            m--; // Reduce the size of the array
        }
    }

    std::vector<std::pair<int, int>> countPairs;

    for (int i = 0; i < n; i++) {
        countPairs.push_back(std::make_pair(count[i], i));
    }

    // Sort the pairs based on the first value in reverse order
    std::sort(countPairs.begin(), countPairs.end(), [](const std::pair<int, int>& a, const std::pair<int, int>& b) {
        return a.first > b.first;
    });

    // Print the sorted pairs
    for (const auto& p : countPairs) {
        std::cout << "count: " << p.first << ", index: " << p.second << std::endl;
    }

    // Print the array count
    for (int i = 0; i < n; i++) {
        std::cout << "count[" << i << "] = " << count[i] << std::endl;
    }

    for (size_t i = 0; i < sink.size(); i++) {
        std::cout << "sink[" << i << "] = " << sink[i] << std::endl;
    }

    // Placeholder for further implementation
    std::cout << "Arrays initialized." << std::endl;

    return 0;
}