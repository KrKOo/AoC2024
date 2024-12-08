#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <unordered_set>


std::vector<std::string> readInputFile(std::string filename)
{
	std::ifstream file(filename);
	if (!file.is_open())
		return {};
	
	std::vector<std::string> lines;
	std::string line;

	while (std::getline(file, line))
		lines.push_back(line);
	
	file.close();
	
	return lines;
}

void getGuardPosition(std::vector<std::string> grid, int& x, int& y)
{
	for (int i = 0; i < grid.size(); i++)
		for (int j = 0; j < grid[i].size(); j++)
			if (grid[i][j] == '^')
			{
				x = j;
				y = i;
				return;
			}
}

int getVisitedCellCount(std::vector<std::string> grid)
{
	int count = 0;
	for (int i = 0; i < grid.size(); i++)
		count += std::count(grid[i].begin(), grid[i].end(), 'X');
	
	return count;
}

void printGrid(std::vector<std::string> grid)
{
	for (int i = 0; i < grid.size(); i++)
	{
		for (int j = 0; j < grid[i].size(); j++)
		{
			std::cout << grid[i][j];
		}
		std::cout << std::endl;
	}
}

int direction[4] = {0, 1, 0, -1};

struct VisitedCell {
	int x, y, dx, dy;

	bool operator==(const VisitedCell& other) const
	{
		return x == other.x && y == other.y && dx == other.dx && dy == other.dy;
	}
};

namespace std {
	template <>
	struct hash<VisitedCell> {
		std::size_t operator()(const VisitedCell& cell) const
		{
			return std::hash<int>()(cell.x) ^ std::hash<int>()(cell.y) ^ std::hash<int>()(cell.dx) ^ std::hash<int>()(cell.dy);
		}
	};
}


int run(std::vector<std::string> &grid, int x, int y)
{
	int initX = x;
	int initY = y;
	int dx_id = 0;
	int dy_id = 3;
	bool isFirst = true;
	std::unordered_set<VisitedCell> visitedCells {{x, y, dx_id, dy_id}};
	
	grid[y][x] = 'X';
	while(true)
	{
		isFirst = false;

		while (true)
		{
			x += direction[dx_id];
			y += direction[dy_id];

			if (visitedCells.contains({x, y, dx_id, dy_id})) return 1;
			if (x < 0 || x >= grid.size() || y < 0 || y >= grid[0].size()) return 0;
			if (grid[y][x] == '#') 
			{
				x -= direction[dx_id];
				y -= direction[dy_id];
				break;
			}

			visitedCells.insert({x, y, dx_id, dy_id});
			grid[y][x] = 'X';
		}
		
		dx_id = (dx_id + 1) % 4;
		dy_id = (dy_id + 1) % 4;
	}
	
	return 1;
}

int part1(std::vector<std::string> grid)
{
	int x, y;
	getGuardPosition(grid, x, y);
	run(grid, x, y);
	return getVisitedCellCount(grid);
}

int part2(std::vector<std::string> grid)
{
	int x, y;
	getGuardPosition(grid, x, y);	
	
	int count = 0;
	for (int i = 0; i < grid.size(); i++)
		for (int j = 0; j < grid[i].size(); j++)
			if (grid[i][j] == '.' || grid[i][j] == '^'){
				std::vector<std::string> newGrid(grid);
				newGrid[i][j] = '#';	
				count += run(newGrid, x, y);
			}
	
	return count;
}

int main()
{
	std::vector<std::string> grid = readInputFile("input.txt");
	std::cout << "Part 1: " << part1(grid) << std::endl;
	std::cout << "Part 2: " << part2(grid) << std::endl;

	return 0;
}
