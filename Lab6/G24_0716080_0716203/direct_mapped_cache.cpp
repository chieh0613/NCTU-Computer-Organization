#include <iostream>
#include <vector>
#include <fstream>
#include <string>
#include<iomanip>
#include<sstream>
#include<cmath>
#include<algorithm>
#include<stdio.h>

using namespace std;

struct block {
	bool valid = false;
	int tag = 0;
};

int main()
{
	ifstream file_i("ICACHE.txt");
	ifstream file_d("DCACHE.txt");
	vector<long long>  byte_addr_i, byte_addr_d;
	string input;
	while (file_i >> input){
		long long tmp;
		stringstream ss;
		ss << hex << input;
		ss >> tmp;
		byte_addr_i.push_back(tmp);
	}
	while (file_d >> input){
		long long tmp;
		stringstream ss;
		ss << hex << input;
		ss >> tmp;
		byte_addr_d.push_back(tmp);
	}
	vector<string> c_out = { "4K", "16K", "64K", "256K" };
	vector<int> c_size = { 4096 ,16384 ,65536,262144 };
	vector<int> b_size = {16, 32, 64, 128, 256};
	int i, j;

	/*I-cache*/
	cout << "ICACHE\n\n";
	for (i = 0; i < c_size.size(); i++)
	{
		for (j = 0; j < b_size.size(); j++)
		{
			int num_of_hit = 0, num_of_miss = 0;
			int num_of_blocks = c_size[i] / b_size[j];

			vector<block> i_cache(num_of_blocks);
			
			for (int k = 0; k < byte_addr_i.size(); k++)
			{
				int block_addr = byte_addr_i[k] / b_size[j];
				int block_num = block_addr % num_of_blocks;
				int block_tag = block_addr / num_of_blocks;
				if (i_cache[block_num].valid)
				{
					if (i_cache[block_num].tag == block_tag)
					{
						num_of_hit++;
					}
					else
					{
						num_of_miss++;
						i_cache[block_num].tag = block_tag;
					}
				}
				else
				{
					num_of_miss++;
					i_cache[block_num].valid = true;
					i_cache[block_num].tag = block_tag;
				}
			}//k

			float hit_rate = ((float)num_of_hit / (float)byte_addr_i.size())*100;
			float miss_rate =((float)num_of_miss / (float)byte_addr_i.size())*100;
			cout << "Cache_size: " << c_out[i] << endl;
			cout << "Block_size: " << b_size[j] << endl;
			cout << "Hit rate: " <<fixed<<setprecision(2)<< hit_rate << "% (" << num_of_hit << "), ";
			cout << "Miss rate: " <<  miss_rate << "% (" << num_of_miss << ")" << endl<<endl;
		}//j
	}//i
	cout << "----------------------------------------------------------------\n\n";

	/*D-cache*/
	cout << "DCACHE\n\n";

	for (i = 0; i < c_size.size(); i++)
	{
		for (j = 0; j < b_size.size(); j++)
		{
			int num_of_hit = 0, num_of_miss = 0;
			int num_of_blocks = c_size[i] / b_size[j];

			vector<block> d_cache(num_of_blocks);

			for (int k = 0; k < byte_addr_d.size(); k++)
			{
				int block_addr = byte_addr_d[k] / b_size[j];
				int block_num = block_addr % num_of_blocks;
				int block_tag = block_addr / num_of_blocks;
				if (d_cache[block_num].valid)
				{
					if (d_cache[block_num].tag == block_tag)
					{
						num_of_hit++;
					}
					else
					{
						num_of_miss++;
						d_cache[block_num].tag = block_tag;
					}
				}
				else
				{
					num_of_miss++;
					d_cache[block_num].valid = true;
					d_cache[block_num].tag = block_tag;
				}
			}//k

			float hit_rate = ((float)num_of_hit / (float)byte_addr_d.size()) * 100;
			float miss_rate = ((float)num_of_miss / (float)byte_addr_d.size()) * 100;
			cout << "Cache_size: " << c_out[i] << endl;
			cout << "Block_size: " << b_size[j] << endl;
			cout << "Hit rate: " << fixed << setprecision(2) << hit_rate << "% (" << num_of_hit << "), ";
			cout << "Miss rate: " << miss_rate << "% (" << num_of_miss << ")" << endl << endl;
		}//j
	}//i

	return 0;
}