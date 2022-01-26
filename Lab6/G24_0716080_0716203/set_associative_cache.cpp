#include <iostream>
#include <vector>
#include <fstream>
#include <string>
#include<iomanip>
#include<sstream>
#include<cmath>
#include<algorithm>
#include<stdio.h>
#include <climits>

using namespace std;

struct block {
	bool valid = false;
	int tag = -1;
	int used = INT_MAX;
};

int main()
{
	ifstream file("LRU.txt");
	vector < long long > byte_addr;
	string input;
	while (file >> input) {
		long long tmp;
		stringstream ss;
		ss << hex << input;
		ss >> tmp;
		byte_addr.push_back(tmp);
	}
	vector<string> c_out = { "1K","2K","4K","8K", "16K","32K", "64K","128K" };
	vector<int> c_size = { 1024,2048, 4096,8192,16384,32768, 65536 ,131072 };
	vector<string> way_out = { "1-Way","2-Way","4-Way","8-Way" };
	vector<int> way = { 1,2,4,8 };
	int  b_size = 64;
	int i, j;

	for (i = 0; i < c_size.size(); i++)
	{
		for (j = 0; j < way.size(); j++)
		{
			int num_of_hit = 0, num_of_miss = 0;
			int num_of_blocks = c_size[i] / b_size;
			int num_of_sets = num_of_blocks / way[j];

			vector<vector<block> > cache(num_of_sets, vector<block>(way[j]));

			for (int k = 0; k < byte_addr.size(); k++)
			{
				int block_addr = byte_addr[k] / b_size;
				int set_num = block_addr % num_of_sets;
				int block_tag = block_addr / num_of_sets;

				bool is_hit = false;
				int least_used_time = INT_MAX;
				int  least_used_id = -1;

				for (int m = 0; m < way[j]; m++)
				{
					if (cache[set_num][m].valid && cache[set_num][m].tag == block_tag)
					{
						cache[set_num][m].used = k;
						num_of_hit++;
						is_hit = true;
					}

					if (cache[set_num][m].used < least_used_time)
					{
						least_used_time = cache[set_num][m].used;
						least_used_id = m;
					}
				}

				if (!is_hit)
				{
					num_of_miss++;
					bool is_placed = false;
					for (int m = 0; m < way[j]; m++)
					{
						if (!cache[set_num][m].valid)
						{
							cache[set_num][m].valid = true;
							cache[set_num][m].tag = block_tag;
							cache[set_num][m].used = k;
							is_placed = true;
							break;
						}
					}

					if (!is_placed)
					{
						cache[set_num][least_used_id].valid = true;
						cache[set_num][least_used_id].tag = block_tag;
						cache[set_num][least_used_id].used = k;
					}
				}
			}//k

			float hit_rate = ((float)num_of_hit / (float)byte_addr.size()) * 100;
			float miss_rate = ((float)num_of_miss / (float)byte_addr.size()) * 100;
			cout << way_out[j] << endl;
			cout << "Cache_size: " << c_out[i] << endl;
			cout << "Block_size: " << b_size << endl;
			cout << "Hit rate: " << fixed << setprecision(2) << hit_rate << "% (" << num_of_hit << "), ";
			cout << "Miss rate: " << miss_rate << "% (" << num_of_miss << ")" << endl << endl;
		}//j
	}//i

	return 0;
}